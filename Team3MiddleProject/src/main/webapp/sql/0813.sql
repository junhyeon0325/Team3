-- tbl_order_items 조회
select *
from   tbl_order_items;

select *
from tbl_order;

select *
from tbl_cart;

-- 장바구니에 넣으면 얼마나 있는지 개수 세는 쿼리
select count(*)
from tbl_cart
where member_no = (select member_no
                   from   tbl_member
                   where  member_id = 'jjh' );

-- 장바구니에 데이터 넣는 쿼리문
insert into tbl_cart(cart_no,
                             product_pcs,
                             product_no,
                             member_no)
        values(CART_NO.nextval,
               1, 
               1,
               (select member_no
                from   tbl_member
                where  member_id = #{memberId} ));

-- tbl_cart조회
select *
from   tbl_cart;

-- 시퀀스 객체 생성
create sequence cart_no;

-- tbl_cart에 데이터 넣기(장바구니 데이터 넣기)
insert into tbl_cart(cart_no,
                     product_pcs,
                     product_no,
                     member_no)
values(CART_NO.nextval, -- 시퀀스 넣기
       1, -- 빈공간은 기본값1
       1,
       (select member_no
        from   tbl_member
        where  member_id = 'jjh' ));

-- 입력받은 member_id에 해당하는 member_no조회
select member_no
from   tbl_member
where  member_id = 'jjh';

-- tbl_member조회
select *
from   tbl_member;

select *
from tbl_cart;

select *
from tbl_product;

alter table tbl_product add discount_rate number default 0;
alter table tbl_product add discount_price number;


CREATE SEQUENCE review_seq;
INSERT INTO tbl_order_items values(1,1,34,1);
insert into tbl_order values(20,'jjh',100,'2025-08-20',20000,'asdf',1);
select *
from tbl_order;
select *
from tbl_order_items;
select *
from tbl_member;
create table tbl_product(                   
    product_no number primary key,
    product_name varchar2(100) not null,
    product_seller varchar2(100) not null,
    product_price number not null,
    product_score number, -- not null
    product_image varchar2(100) not null,
    expiration_date date not null,
    product_about varchar2(500),
    maincategory varchar2(100) not null
);

select *
from tbl_review;
alter table tbl_review
add member_name varchar2(100);
alter table tbl_review
add review_score number;
create table tbl_review(
    review_no number primary key,
    review_content varchar2(1000) not null,
    review_image varchar2(100),
    review_score number,  tbl_product占쏙옙 product_score 占쌍는듸옙 占쏘떻占쏙옙 占쏙옙占쏙옙占쏙옙占? 확占쏙옙
    review_date date default sysdate,             --default 占쏙옙 sysdate
    product_no number not null,
    
    
    constraint fk_review_product
    foreign key(product_no)
    references tbl_product(product_no)
    on delete cascade,
    
    constraint fk_review_order
    foreign key(order_no)
    references tbl_order(order_no)
    on delete cascade
);
alter table tbl_product modify maincategory invisible;
alter table tbl_product modify maincategory visible;
select *
from tbl_product;
drop table tbl_reply;
delete from tbl_order;
select *
from tbl_cart;

select sequence_name
from user_sequences;
drop sequence product_seq;
select product_seq.currval from dual;
SELECT
    constraint_name,
    constraint_type,
    table_name,
    column_name
FROM
    user_cons_columns
WHERE
    constraint_name = 'SYS_C008462';
CREATE SEQUENCE product_seq START WITH 1 INCREMENT BY 1;
INSERT INTO tbl_product values(product_seq.nextval, '가자미', 'Team3', 12000, 4, 'product-IMG/가자미.jpg', TO_DATE('2025-08-25', 'YYYY-MM-DD'), '갓 잡은 신선한 가자미!', '수산');
INSERT INTO tbl_product values(product_seq.nextval, '갈치', 'Team3', 18000, 5, 'product-IMG/갈치.jpg', TO_DATE('2025-09-10', 'YYYY-MM-DD'), '밥도둑 갈치!', '수산');
INSERT INTO tbl_product values(product_seq.nextval, '감자', 'Team3', 5000, 3, 'product-IMG/감자.jpg', TO_DATE('2025-10-01', 'YYYY-MM-DD'), '강원도 햇감자!', '채소');
INSERT INTO tbl_product values(product_seq.nextval, '고구마', 'Team3', 6000, 4, 'product-IMG/고구마.jpg', TO_DATE('2025-10-15', 'YYYY-MM-DD'), '달콤한 꿀고구마!', '채소');
INSERT INTO tbl_product values(product_seq.nextval, '고등어', 'Team3', 9000, 5, 'product-IMG/고등어.jpg', TO_DATE('2025-09-05', 'YYYY-MM-DD'), '노르웨이산 고등어!', '수산');
INSERT INTO tbl_product values(product_seq.nextval, '간마늘', 'Team3', 3000, 4, 'product-IMG/간마늘.jpg', TO_DATE('2025-11-20', 'YYYY-MM-DD'), '요리의 필수품 간마늘!', '채소');
INSERT INTO tbl_product values(product_seq.nextval, '깻잎', 'Team3', 2000, 5, 'product-IMG/깻잎.jpg', TO_DATE('2025-09-30', 'YYYY-MM-DD'), '향긋한 깻잎!', '채소');
INSERT INTO tbl_product values(product_seq.nextval, '낙지', 'Team3', 11000, 5, 'product-IMG/낙지.jpg', TO_DATE('2025-10-25', 'YYYY-MM-DD'), '바다의 보양식 낙지!', '수산');
INSERT INTO tbl_product values(product_seq.nextval, '냉동과일', 'Team3', 8000, 4, 'product-IMG/냉동과일.jpg', TO_DATE('2026-01-10', 'YYYY-MM-DD'), '달콤 시원한 냉동과일!', '과일');
INSERT INTO tbl_product values(product_seq.nextval, '달걀', 'Team3', 7000, 5, 'product-IMG/달걀.jpg', TO_DATE('2025-09-01', 'YYYY-MM-DD'), '신선한 유정란!', '정육');
INSERT INTO tbl_product values(product_seq.nextval, '닭', 'Team3', 10000, 4, 'product-IMG/닭.jpg', TO_DATE('2025-08-28', 'YYYY-MM-DD'), '신선한 닭고기!', '정육');
INSERT INTO tbl_product values(product_seq.nextval, '당근', 'Team3', 4000, 3, 'product-IMG/당근.jpg', TO_DATE('2025-11-05', 'YYYY-MM-DD'), '싱싱한 유기농 당근!', '채소');
INSERT INTO tbl_product values(product_seq.nextval, '대파', 'Team3', 2500, 4, 'product-IMG/대파.jpg', TO_DATE('2025-10-18', 'YYYY-MM-DD'), '국내산 대파!', '채소');
INSERT INTO tbl_product values(product_seq.nextval, '등심', 'Team3', 25000, 5, 'product-IMG/등심.jpg', TO_DATE('2025-12-01', 'YYYY-MM-DD'), '육즙 가득한 소고기 등심!', '정육');
INSERT INTO tbl_product values(product_seq.nextval, '마늘', 'Team3', 6000, 5, 'product-IMG/마늘.jpg', TO_DATE('2025-11-15', 'YYYY-MM-DD'), '통통한 의성 마늘!', '채소');
INSERT INTO tbl_product values(product_seq.nextval, '방어', 'Team3', 20000, 5, 'product-IMG/방어.jpg', TO_DATE('2025-12-25', 'YYYY-MM-DD'), '제철 맞은 싱싱한 방어!', '수산');
INSERT INTO tbl_product values(product_seq.nextval, '브로콜리', 'Team3', 4500, 4, 'product-IMG/브로콜리.jpg', TO_DATE('2025-10-05', 'YYYY-MM-DD'), '영양 가득 브로콜리!', '채소');
INSERT INTO tbl_product values(product_seq.nextval, '살치살', 'Team3', 28000, 5, 'product-IMG/살치살.jpg', TO_DATE('2025-12-10', 'YYYY-MM-DD'), '입에서 살살 녹는 살치살!', '정육');
INSERT INTO tbl_product values(product_seq.nextval, '안심', 'Team3', 30000, 5, 'product-IMG/안심.jpg', TO_DATE('2025-12-05', 'YYYY-MM-DD'), '부드러운 소고기 안심!', '정육');
INSERT INTO tbl_product values(product_seq.nextval, '양념소불고기', 'Team3', 18000, 4, 'product-IMG/양념소불고기.jpg', TO_DATE('2025-11-25', 'YYYY-MM-DD'), '간편하게 즐기는 양념 소불고기!', '정육');
INSERT INTO tbl_product values(product_seq.nextval, '양배추', 'Team3', 3500, 4, 'product-IMG/양배추.jpg', TO_DATE('2025-11-01', 'YYYY-MM-DD'), '아삭한 양배추!', '채소');
INSERT INTO tbl_product values(product_seq.nextval, '양파', 'Team3', 3000, 4, 'product-IMG/양파.jpg', TO_DATE('2025-10-22', 'YYYY-MM-DD'), '어디에나 잘 어울리는 양파!', '채소');
INSERT INTO tbl_product values(product_seq.nextval, '연어필렛', 'Team3', 16000, 5, 'product-IMG/연어필렛.jpg', TO_DATE('2025-09-15', 'YYYY-MM-DD'), '신선한 노르웨이산 연어필렛!', '수산');
INSERT INTO tbl_product values(product_seq.nextval, '오이', 'Team3', 2500, 3, 'product-IMG/오이.jpg', TO_DATE('2025-09-20', 'YYYY-MM-DD'), '아삭하고 시원한 오이!', '채소');
INSERT INTO tbl_product values(product_seq.nextval, '오징어', 'Team3', 13000, 4, 'product-IMG/오징어.jpg', TO_DATE('2025-10-08', 'YYYY-MM-DD'), '쫄깃한 동해안 오징어!', '수산');
INSERT INTO tbl_product values(product_seq.nextval, '와규', 'Team3', 45000, 5, 'product-IMG/와규.jpg', TO_DATE('2026-01-20', 'YYYY-MM-DD'), '고급스러운 와규!', '정육');
INSERT INTO tbl_product values(product_seq.nextval, '키조개', 'Team3', 10000, 4, 'product-IMG/키조개.jpg', TO_DATE('2025-11-10', 'YYYY-MM-DD'), '쫄깃한 키조개 관자!', '수산');
INSERT INTO tbl_product values(product_seq.nextval, '파프리카', 'Team3', 5000, 4, 'product-IMG/파프리카.jpg', TO_DATE('2025-11-18', 'YYYY-MM-DD'), '알록달록 파프리카!', '채소');
INSERT INTO tbl_product values(product_seq.nextval, '표고버섯', 'Team3', 7000, 5, 'product-IMG/표고버섯.jpg', TO_DATE('2025-12-15', 'YYYY-MM-DD'), '향긋한 표고버섯!', '채소');  

-- update 적립금
update tbl_member
set point = 10000;

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
delete FROM tbl_order_items;
ALTER TABLE TBL_ORDER DROP COLUMN PRODUCT_NO;
drop table tbl_order_items;

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

delete from tbl_event;
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
    maincategory varchar2(100) not null,
    --subcategory varchar2(100) not null,
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


