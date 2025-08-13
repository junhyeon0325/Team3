create table tbl_member(
    member_no number primary key,
    member_name varchar2(10) not null,
    member_id varchar2(30) not null,
    member_pwd varchar2(30) not null,
    member_phone varchar2(11) not null,     -- 수정
    member_email varchar2(30) not null,
    --member_age number not null,
    member_birth varchar2(20) not null,     -- 수정
    member_address varchar2(100) not null,
    member_gender varchar2(10) not null,
    point number not null
);

create table tbl_product(                   -- 수정
    product_no number primary key,
    product_name varchar2(100) not null,
    product_seller varchar2(100) not null,
    product_price number not null,
    --maincategory varchar2(100) not null,
    subcategory varchar2(100) not null,
    product_score number, -- not null
    product_image varchar2(100) not null,
    product_about varchar2(500),
    expiration_date date not null           -- 수정
);

create table tbl_cart(
    cart_no number primary key,
    product_pcs number not null,    -- pcs = pieces의 약자로 1pcs = 1개를 뜻함
    product_no number not null,
    member_no number not null,
    
    constraint fk_cart_member
    foreign key(member_no)
    references tbl_member(member_no)
    on delete cascade,
      
    constraint fk_cart_product
    foreign key(product_no)
    references tbl_product(product_no)
    on delete cascade
);

create table tbl_order_items(
    order_item_no number primary key,
    product_pcs number not null,
    product_no number not null,
    /*order_no number not null  --> 주문 상세가 먼저이면 주문의 주문번호 primary key 보다 먼저 만들어지는데
    foreign key로 만들어서 쓰는게 맞는지 확인*/
    
    constraint fk_items_product
    foreign key(product_no)
    references tbl_product(product_no)
    on delete cascade
    
    /*constraint fk_items_order
    foreign key(order_no)
    references tbl_order(order_no)
    on delete cascade*/
);

create table tbl_order(
    order_no number primary key,
    order_address varchar2(100) not null,
    used_point number default 0 not null, -- default 값 0
    order_date date default sysdate,      -- default 값 sysdate
    order_price number not null,
    order_request varchar2(100),          -- 수정
    member_no number not null,
    product_no number not null,
    
    constraint fk_order_member
    foreign key(member_no)
    references tbl_member(member_no),
    --on delete cascade   -->주문내역은 회원정보가 삭제되어도 가지고 있을지 확인
    
    constraint fk_order_product
    foreign key(product_no)
    references tbl_product(product_no)
);

create table tbl_review(
    review_no number primary key,
    review_content varchar2(1000) not null,
    review_image varchar2(100),
    --review_score number,  tbl_product에 product_score 있는데 어떻게 사용할지 확인
    review_date date default sysdate,             --default 값 sysdate
    product_no number not null,
    order_no number not null,
    
    constraint fk_review_product
    foreign key(product_no)
    references tbl_product(product_no)
    on delete cascade,
    
    constraint fk_review_order
    foreign key(order_no)
    references tbl_order(order_no)
    on delete cascade
);

create table tbl_event(
    event_no number primary key,    -- primary key 필요할거 같아서 추가했는데 필요하신지 확인
    sale number,
    product_no number not null,
    
    constraint fk_event_product
    foreign key(product_no)
    references tbl_product(product_no)
    --on delete cascade
);
