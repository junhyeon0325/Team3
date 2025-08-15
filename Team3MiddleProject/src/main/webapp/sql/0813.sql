-- ��� ��ȣ�ϰ� ��ٱ��� ��ȣ�ϰ� ���� ��ٱ��ϸ� ��� �� �����ϴ� ���� ���
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

-- ���� �̺�Ʈ ��ǰ ������ ��ȸ
select *
from   tbl_event;

-- ���� �̺�Ʈ ��ǰ ������ ����
insert into tbl_event
values (1,0.5,1);

-- ���� �̺�Ʈ ��ǰ ���̺� ����
DROP table tbl_event;

-- ���� �̺�Ʈ ��ǰ ���̺� ����
create table tbl_event(
    event_no number primary key,    -- primary key �ʿ��Ұ� ���Ƽ� �߰��ߴµ� �ʿ��Ͻ��� Ȯ��
    sale number,
    product_no number not null,
    
    constraint fk_event_product
    foreign key(product_no)
    references tbl_product(product_no)
    --on delete cascade
);

-- ��ٱ��� ���� ����
update tbl_cart
set product_pcs = 3
where cart_no = 10;

-- ��ٱ��� ������ ���
select *
from   tbl_cart;

-- ��ǰ������ ��ȸ
select *
from   tbl_product;

-- ȸ�������� ��ȸ
select *
from   tbl_member;

-- ��� ��ȣ�ϰ� ��ٱ��� ��ȣ�ϰ� ���� ��ٱ��ϸ� ���
SELECT d.*,
       c.*,
       m.point
FROM   tbl_member m
JOIN   tbl_cart c
  ON   m.member_no = c.member_no
join   tbl_product d
  on   c.product_no = d.product_no
WHERE  m.member_id = 'jjh';

-- ��ٱ��� ������ ���
select *
from   tbl_cart;

-- ��ٱ��� ������ ����
delete from tbl_cart
where  cart_no = 1;

-- ��ٱ��� ������ �߰�
insert into tbl_cart
values (10,1,1,1);
insert into tbl_cart
values (1,3,2,1);
insert into tbl_cart
values (2,2,3,1);
insert into tbl_cart
values (3,3,1,2);

-- ȸ�� ������ ���
INSERT ALL
    INTO tbl_member VALUES (1, '������', 'jjh', 'qwer1234', '01026104902', 'jjh990325@gmail.com', '19990325', '���ϵ� ���� �Ͼ��� �Ͼ�� 29', '��', 100)
    INTO tbl_member VALUES (2, 'ȫ�浿', 'hgd', 'qwer1234', '01027156901', 'hhd942325@gmail.com', '20001201', '���ϵ� ���� �Ͼ��� �Ͼ�� 01', '��', 150)
    INTO tbl_member VALUES (3, '���浿', 'ggd', 'qwer1234', '01027556811', 'ghd922525@gmail.com', '19901201', '���ϵ� ���� �Ͼ��� �Ͼ�� 12', '��', 10)
SELECT * FROM dual;   

-- ��ǰ ������ ���
INSERT ALL
    INTO tbl_product VALUES (1, '���� �����', '�������', 3990, 'ä��', 4.6, 'cabbage.jpg', '�ƻ����� �������� �����', TO_DATE('2025-08-31', 'YYYY-MM-DD'))
    INTO tbl_product VALUES (2, '���� �����', '�������', 3990, 'ä��', 4.8, 'cabbage.jpg', '�ƻ����� �������� �����', TO_DATE('2025-09-05', 'YYYY-MM-DD'))
    INTO tbl_product VALUES (3, '[KF365] ��ٴٱ���� 3��', '�������', 3490, 'ä��', 4.8, 'cucumber.jpg', '�ƻ��ϰ� �ż��� ����', TO_DATE('2025-08-26', 'YYYY-MM-DD'))
SELECT * FROM dual;    

drop table tbl_member;

create table tbl_member(
    member_no number primary key,
    member_name varchar2(10) not null,
    member_id varchar2(30) not null,
    member_pwd varchar2(30) not null,
    member_phone varchar2(11) not null,     -- ����
    member_email varchar2(30) not null,
    --member_age number not null,
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
    --maincategory varchar2(100) not null,
    subcategory varchar2(100) not null,
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