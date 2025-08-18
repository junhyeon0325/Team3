create table tbl_member(
    member_no number primary key,
    member_name varchar2(10) not null,
    member_id varchar2(30) not null,
    member_pwd varchar2(30) not null,
    member_phone varchar2(11) not null,     -- ����
    member_email varchar2(30) not null,
    member_birth varchar2(20) not null,     -- ����
    member_address varchar2(100) not null,
    member_gender varchar2(10) not null,
    point number not null
);

create table tbl_product(                   -- ����
    product_no number primary key,
    product_name varchar2(100) not null,
    product_seller varchar2(100) not null,
    product_price number not null,
    maincategory varchar2(100) not null,
    product_score number, -- not null
    product_image varchar2(100) not null,
    product_about varchar2(500),
    expiration_date date not null           -- ����
);

create table tbl_cart(
    cart_no number primary key,
    product_pcs number not null,    -- pcs = pieces�� ���ڷ� 1pcs = 1���� ����
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
    /*order_no number not null  --> �ֹ� �󼼰� �����̸� �ֹ��� �ֹ���ȣ primary key ���� ���� ��������µ�
    foreign key�� ���� ���°� �´��� Ȯ��*/
    
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
    used_point number default 0 not null, -- default �� 0
    order_date date default sysdate,      -- default �� sysdate
    order_price number not null,
    order_request varchar2(100),          -- ����
    member_no number not null,
    product_no number not null,
    
    constraint fk_order_member
    foreign key(member_no)
    references tbl_member(member_no),
    --on delete cascade   -->�ֹ������� ȸ�������� �����Ǿ ������ ������ Ȯ��
    
    constraint fk_order_product
    foreign key(product_no)
    references tbl_product(product_no)
);

create table tbl_review(
    review_no number primary key,
    review_content varchar2(1000) not null,
    review_image varchar2(100),
    --review_score number,  tbl_product�� product_score �ִµ� ��� ������� Ȯ��
    review_date date default sysdate,             --default �� sysdate
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
    event_no number primary key,    -- primary key �ʿ��Ұ� ���Ƽ� �߰��ߴµ� �ʿ��Ͻ��� Ȯ��
    sale number,
    product_no number not null,
    
    constraint fk_event_product
    foreign key(product_no)
    references tbl_product(product_no)
    --on delete cascade
);

create sequence product_seq;

alter table tbl_product drop column subcategory;

delete from tbl_product
where product_name = '���ҺҰ��';

select *
from tbl_product;

select product_seq.currval from dual;  -- ���� ������ ��
select max(product_no) from tbl_product;

alter sequence product_seq increment by 300;
select product_seq.nextval from dual;         -- ȣ��
alter sequence product_seq increment by 1;    -- �ٽ� 1�� ����



commit;



create sequence product_seq;

delete from tbl_product;

alter table tbl_product add maincategory varchar2(100);

insert all 
    into tbl_product(product_no, product_name, product_seller, product_price, product_score,
                     product_image, expiration_date, product_about, maincategory)
    values(product_seq.nextval, '감자', 'Team3', 3000, 4, 'product-IMG/감자.jpg', TO_DATE('2025-12-31', 'YYYY-MM-DD'),
       '싱싱한 감자입니다', '채소')
select * from dual;


insert into tbl_product(product_no, product_name, product_seller, product_price, product_score,
                     product_image, expiration_date, product_about, maincategory)
    values(product_seq.nextval, '꽃갈비살', 'Team3', 15000, 5, 'product-IMG/꽃갈비살.jpg',
           TO_DATE('2025-12-31', 'YYYY-MM-DD'), '맛도 잡고 양도 잡은 꽃갈비살!', '정육');         
insert into tbl_product(product_no, product_name, product_seller, product_price, product_score,
                     product_image, expiration_date, product_about, maincategory)
    values(product_seq.nextval, '살치살', 'Team3', 15000, 5, 'product-IMG/살치살.jpg',
           TO_DATE('2025-12-31', 'YYYY-MM-DD'), '맛도 잡고 양도 잡은 살치살!', '정육');         
insert into tbl_product(product_no, product_name, product_seller, product_price, product_score,
                     product_image, expiration_date, product_about, maincategory)
    values(product_seq.nextval, '등심', 'Team3', 15000, 5, 'product-IMG/등심.jpg',
           TO_DATE('2025-12-31', 'YYYY-MM-DD'), '맛도 잡고 양도 잡은 등심!', '정육');          
insert into tbl_product(product_no, product_name, product_seller, product_price, product_score,
                     product_image, expiration_date, product_about, maincategory)
    values(product_seq.nextval, '안심', 'Team3', 15000, 5, 'product-IMG/안심.jpg',
           TO_DATE('2025-12-31', 'YYYY-MM-DD'), '맛도 잡고 양도 잡은 안심!', '정육');       
insert into tbl_product(product_no, product_name, product_seller, product_price, product_score,
                     product_image, expiration_date, product_about, maincategory)
    values(product_seq.nextval, '와규', 'Team3', 15000, 5, 'product-IMG/와규.jpg',
           TO_DATE('2025-12-31', 'YYYY-MM-DD'), '맛도 잡고 양도 잡은 와규!', '정육');           
insert into tbl_product(product_no, product_name, product_seller, product_price, product_score,
                     product_image, expiration_date, product_about, maincategory)
    values(product_seq.nextval, '닭', 'Team3', 15000, 5, 'product-IMG/닭.jpg',
           TO_DATE('2025-12-31', 'YYYY-MM-DD'), '맛도 잡고 양도 잡은 닭!', '정육');    
insert into tbl_product(product_no, product_name, product_seller, product_price, product_score,
                     product_image, expiration_date, product_about, maincategory)
    values(product_seq.nextval, '달걀', 'Team3', 15000, 5, 'product-IMG/달걀.jpg',
           TO_DATE('2025-12-31', 'YYYY-MM-DD'), '맛도 잡고 양도 잡은 달걀!', '정육');
insert into tbl_product(product_no, product_name, product_seller, product_price, product_score,
                     product_image, expiration_date, product_about, maincategory)
    values(product_seq.nextval, '양념소불고기', 'Team3', 15000, 5, 'product-IMG/양념소불고기.jpg',
           TO_DATE('2025-12-31', 'YYYY-MM-DD'), '맛도 잡고 양도 잡은 양념소불고기!', '정육');


insert into tbl_product(product_no, product_name, product_seller, product_price, product_score,
                     product_image, expiration_date, product_about, maincategory)
    values(product_seq.nextval, '연어필렛', 'Team3', 15000, 5, 'product-IMG/연어필렛.jpg',
           TO_DATE('2025-12-31', 'YYYY-MM-DD'), '맛도 잡고 양도 잡은 연어필렛!', '수산');
insert    into tbl_product(product_no, product_name, product_seller, product_price, product_score,
                     product_image, expiration_date, product_about, maincategory)
    values(product_seq.nextval, '키조개', 'Team3', 15000, 5, 'product-IMG/키조개.jpg',
           TO_DATE('2025-12-31', 'YYYY-MM-DD'), '맛도 잡고 양도 잡은 키조개!', '수산');
insert    into tbl_product(product_no, product_name, product_seller, product_price, product_score,
                     product_image, expiration_date, product_about, maincategory)
    values(product_seq.nextval, '오징어', 'Team3', 15000, 5, 'product-IMG/오징어.jpg',
           TO_DATE('2025-12-31', 'YYYY-MM-DD'), '맛도 잡고 양도 잡은 오징어!', '수산');
insert    into tbl_product(product_no, product_name, product_seller, product_price, product_score,
                     product_image, expiration_date, product_about, maincategory)
    values(product_seq.nextval, '방어', 'Team3', 15000, 5, 'product-IMG/방어.jpg',
           TO_DATE('2025-12-31', 'YYYY-MM-DD'), '맛도 잡고 양도 잡은 방어!', '수산');
insert    into tbl_product(product_no, product_name, product_seller, product_price, product_score,
                     product_image, expiration_date, product_about, maincategory)
    values(product_seq.nextval, '낙지', 'Team3', 15000, 5, 'product-IMG/낙지.jpg',
           TO_DATE('2025-12-31', 'YYYY-MM-DD'), '맛도 잡고 양도 잡은 낙지!', '수산');
insert    into tbl_product(product_no, product_name, product_seller, product_price, product_score,
                     product_image, expiration_date, product_about, maincategory)
    values(product_seq.nextval, '고등어', 'Team3', 15000, 5, 'product-IMG/고등어.jpg',
           TO_DATE('2025-12-31', 'YYYY-MM-DD'), '맛도 잡고 양도 잡은 고등어!', '수산');
insert    into tbl_product(product_no, product_name, product_seller, product_price, product_score,
                     product_image, expiration_date, product_about, maincategory)
    values(product_seq.nextval, '갈치', 'Team3', 15000, 5, 'product-IMG/갈치.jpg',
           TO_DATE('2025-12-31', 'YYYY-MM-DD'), '맛도 잡고 양도 잡은 갈치!', '수산');
insert    into tbl_product(product_no, product_name, product_seller, product_price, product_score,
                     product_image, expiration_date, product_about, maincategory)
    values(product_seq.nextval, '가자미', 'Team3', 15000, 5, 'product-IMG/가자미.jpg',
           TO_DATE('2025-12-31', 'YYYY-MM-DD'), '맛도 잡고 양도 잡은 가자미!', '수산');


commit;

