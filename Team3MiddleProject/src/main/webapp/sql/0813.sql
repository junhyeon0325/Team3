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

-- 할인 이벤트 상품 데이터 조회
select *
from   tbl_event;

-- 할인 이벤트 상품 데이터 생성
insert into tbl_event
values (1,0.5,1);

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

-- 회원 데이터 등록
INSERT ALL
    INTO tbl_member VALUES (1, '장준현', 'jjh', 'qwer1234', '01026104902', 'jjh990325@gmail.com', '19990325', '경상북도 경산시 하양읍 하양로 29', '남', 100)
    INTO tbl_member VALUES (2, '홍길동', 'hgd', 'qwer1234', '01027156901', 'hhd942325@gmail.com', '20001201', '경상북도 경산시 하양읍 하양로 01', '여', 150)
    INTO tbl_member VALUES (3, '강길동', 'ggd', 'qwer1234', '01027556811', 'ghd922525@gmail.com', '19901201', '경상북도 경산시 하양읍 하양로 12', '남', 10)
SELECT * FROM dual;   

-- 상품 데이터 등록
INSERT ALL
    INTO tbl_product VALUES (1, '한통 양배추', '샛별배송', 3990, '채소', 4.6, 'cabbage.jpg', '아삭함이 오래가는 양배추', TO_DATE('2025-08-31', 'YYYY-MM-DD'))
    INTO tbl_product VALUES (2, '한통 양배추', '샛별배송', 3990, '채소', 4.8, 'cabbage.jpg', '아삭함이 오래가는 양배추', TO_DATE('2025-09-05', 'YYYY-MM-DD'))
    INTO tbl_product VALUES (3, '[KF365] 백다다기오이 3입', '샛별배송', 3490, '채소', 4.8, 'cucumber.jpg', '아삭하고 신선한 오이', TO_DATE('2025-08-26', 'YYYY-MM-DD'))
SELECT * FROM dual;    

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