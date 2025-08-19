select count(*)
		from tbl_order o
		join tbl_member m
		on m.member_no = o.member_no
		join tbl_order_items i
		on o.order_no = i.order_no
		where m.member_id = jjh
		and o.product_no = 4;
        
select *
from tbl_order_items;

ALTER TABLE TBL_ORDER DROP COLUMN PRODUCT_NO;

select *
from   tbl_cart;

select *
from   tbl_member;

select *
from tbl_order_items;

drop table tbl_order_items;

-- 
select *
from   tbl_order;

-- order_item_no 시퀀스 생성 (이 SQL은 DB에서 한 번만 실행합니다)
CREATE SEQUENCE order_item_no_seq START WITH 1 INCREMENT BY 1;

-- 결제 완료 후 생성되는 주문데이터 상세 테이블(수량) 새로만듬
create table tbl_order_items(
    -- DEFAULT를 먼저 지정하고 PRIMARY KEY를 나중에 지정합니다.
    order_item_no number DEFAULT order_item_no_seq.NEXTVAL primary key, -- <<--- 이 부분 수정
    product_pcs number not null,
    product_no number not null,
    order_no number not null, -- 이 컬럼이 활성화되어 있고 NOT NULL인지 다시 확인
    
    constraint fk_items_product
    foreign key(product_no)
    references tbl_product(product_no),
    
    constraint fk_items_order
    foreign key(order_no)
    references tbl_order(order_no)
);
-- 결제 완료 후 생성되는 주문데이터 상세 테이블(수량)
create table tbl_order_items(
    order_item_no number primary key,
    product_pcs number not null,
    product_no number not null,
    order_no number not null  
    
    constraint fk_items_product
    foreign key(product_no)
    references tbl_product(product_no)
    on delete cascade,
    
    constraint fk_items_order
    foreign key(order_no)
    references tbl_order(order_no)
    on delete cascade
);

-- 결제 완료후 생성되는 주문데이터 테이블
create table tbl_order(
    order_no number primary key,
    order_address varchar2(100) not null,
    used_point number default 0 not null, -- default 占쏙옙 0
    order_date date default sysdate,      -- default 占쏙옙 sysdate
    order_price number not null,
    order_request varchar2(100),          -- 占쏙옙占쏙옙
    member_no number not null,
    product_no number not null,
    
    constraint fk_order_member
    foreign key(member_no)
    references tbl_member(member_no),
    --on delete cascade   -->占쌍뱄옙占쏙옙占쏙옙占쏙옙 회占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占실어도 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 확占쏙옙
    
    constraint fk_order_product
    foreign key(product_no)
    references tbl_product(product_no)
);
--20250819

-- 주문/결제에 필요한 회원정보 가져오기
select member_no,
       member_name,
       member_phone,
       member_address
from   tbl_member
where  member_id = 'jjh';

-- 멤버 번호하고 장바구니 번호하고 같은 장바구니를 출력 및 할인하는 물건 출력
SELECT d.*,
       c.*,
       m.point,
       e.event_no,
       e.sale
FROM   tbl_member m
JOIN   tbl_cart c
  ON   m.member_no = c.member_no
join   tbl_product d
  on   c.product_no = d.product_no
left join tbl_event e
  on   d.product_no = e.product_no
WHERE  m.member_id = 'jjh';

-- 할인 이벤트 상풍 데이터 삭제
delete from tbl_event
where event_no = 2;

-- 할인 이벤트 상품 데이터 조회
select *
from   tbl_event;

-- 할인 이벤트 상품 데이터 생성
insert into tbl_event
values (1,0.5,1);
insert into tbl_event
values (2,0.1,2);
insert into tbl_event
values (3,0.2,3);

-- 할인 이벤트 상품 테이블 삭제
DROP table tbl_event;

-- 할인 이벤트 상품 테이블 생성
create table tbl_event(
    event_no number primary key,    -- primary key 필요할거 같아서 추가했는데 필요하신지 확인
    sale number,
    product_no number not null,
    
    constraint fk_event_product
    foreign key(product_no)
    references tbl_product(product_no)
    --on delete cascade
);

-- 장바구니 수량 수정
update tbl_cart
set product_pcs = 3
where cart_no = 10;

-- 장바구니 데이터 출력
select *
from   tbl_cart;

-- 상품데이터 조회
select *
from   tbl_product;

-- 회원데이터 조회
select *
from   tbl_member;

-- 멤버 번호하고 장바구니 번호하고 같은 장바구니를 출력
SELECT d.*,
       c.*,
       m.point
FROM   tbl_member m
JOIN   tbl_cart c
  ON   m.member_no = c.member_no
join   tbl_product d
  on   c.product_no = d.product_no
WHERE  m.member_id = 'jjh';

-- 장바구니 데이터 출력
select *
from   tbl_cart;

-- 장바구니 데이터 삭제
delete from tbl_cart
where  cart_no = 1;

-- 장바구니 데이터 추가
insert into tbl_cart
values (10,1,1,1);
insert into tbl_cart
values (1,3,2,1);
insert into tbl_cart
values (2,2,3,1);
insert into tbl_cart
values (3,3,1,2);
insert into tbl_cart
values (4,1,4,1);

-- 회원 데이터 등록
INSERT ALL
    INTO tbl_member VALUES (1, '장준현', 'jjh', 'qwer1234', '01026104902', 'jjh990325@gmail.com', '19990325', '경상북도 경산시 하양읍 하양로 29', '남', 100)
    INTO tbl_member VALUES (2, '홍길동', 'hgd', 'qwer1234', '01027156901', 'hhd942325@gmail.com', '20001201', '경상북도 경산시 하양읍 하양로 01', '여', 150)
    INTO tbl_member VALUES (3, '강길동', 'ggd', 'qwer1234', '01027556811', 'ghd922525@gmail.com', '19901201', '경상북도 경산시 하양읍 하양로 12', '남', 10)
SELECT * FROM dual;

update tbl_member
   set point = 10000
where  member_no = 1;


-- 상품 데이터 등록
INSERT ALL
    INTO tbl_product VALUES (1, '한통 양배추', '샛별배송', 3990, '채소', 4.6, 'cabbage.jpg', '아삭함이 오래가는 양배추', TO_DATE('2025-08-31', 'YYYY-MM-DD'))
    INTO tbl_product VALUES (2, '한통 양배추', '샛별배송', 3990, '채소', 4.8, 'cabbage.jpg', '아삭함이 오래가는 양배추', TO_DATE('2025-09-05', 'YYYY-MM-DD'))
    INTO tbl_product VALUES (3, '[KF365] 백다다기오이 3입', '샛별배송', 3490, '채소', 4.8, 'cucumber.jpg', '아삭하고 신선한 오이', TO_DATE('2025-08-26', 'YYYY-MM-DD'))
    INTO tbl_product VALUES (4, '오이', '샛별배송', 2000, '채소', 4.8, 'cucumber.jpg', '아삭하고 신선한 오이', TO_DATE('2025-08-26', 'YYYY-MM-DD'))
SELECT * FROM dual;    

insert into tbl_product
values (4, '오이', '샛별배송', 2000, '채소', 4.8, 'cucumber.jpg', '아삭하고 신선한 오이', TO_DATE('2025-08-26', 'YYYY-MM-DD'));

drop table tbl_member;

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

select *
from tbl_product;

UPDATE tbl_product
SET maincategory = '채소';


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