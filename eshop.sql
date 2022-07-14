-- Table: public.cart

-- DROP TABLE IF EXISTS public.cart;

CREATE TABLE IF NOT EXISTS public.cart
(
    user_id bigint NOT NULL,
    CONSTRAINT cart_pkey1 PRIMARY KEY (user_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.cart
    OWNER to postgres;
	
----------------------------------------------------

-- Table: public.discount

-- DROP TABLE IF EXISTS public.discount;

CREATE TABLE IF NOT EXISTS public.discount
(
    id character varying COLLATE pg_catalog."default" NOT NULL,
    status bigint,
    CONSTRAINT discount_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.discount
    OWNER to postgres;
	
------------------------------------------------------

-- Table: public.order_main

-- DROP TABLE IF EXISTS public.order_main;

CREATE TABLE IF NOT EXISTS public.order_main
(
    order_id bigint NOT NULL,
    buyer_address character varying(255) COLLATE pg_catalog."default",
    buyer_email character varying(255) COLLATE pg_catalog."default",
    buyer_name character varying(255) COLLATE pg_catalog."default",
    buyer_phone character varying(255) COLLATE pg_catalog."default",
    create_time timestamp without time zone,
    order_amount numeric(19,2) NOT NULL,
    order_status integer NOT NULL DEFAULT 0,
    update_time timestamp without time zone,
    CONSTRAINT order_main_pkey PRIMARY KEY (order_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.order_main
    OWNER to postgres;
	
------------------------------------------------------

-- Table: public.product_category

-- DROP TABLE IF EXISTS public.product_category;

CREATE TABLE IF NOT EXISTS public.product_category
(
    category_id integer NOT NULL,
    category_name character varying(255) COLLATE pg_catalog."default",
    category_type integer,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    CONSTRAINT product_category_pkey PRIMARY KEY (category_id),
    CONSTRAINT uk_6kq6iveuim6wd90cxo5bksumw UNIQUE (category_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_category
    OWNER to postgres;
	
--------------------------------------------------------

-- Table: public.product_in_order

-- DROP TABLE IF EXISTS public.product_in_order;

CREATE TABLE IF NOT EXISTS public.product_in_order
(
    id bigint NOT NULL,
    category_type integer NOT NULL,
    count integer,
    product_description character varying(255) COLLATE pg_catalog."default" NOT NULL,
    product_icon character varying(255) COLLATE pg_catalog."default",
    product_id character varying(255) COLLATE pg_catalog."default",
    product_name character varying(255) COLLATE pg_catalog."default",
    product_price numeric(19,2) NOT NULL,
    product_stock integer,
    cart_user_id bigint,
    order_id bigint,
    CONSTRAINT product_in_order_pkey PRIMARY KEY (id),
    CONSTRAINT fkt0sfj3ffasrift1c4lv3ra85e FOREIGN KEY (order_id)
        REFERENCES public.order_main (order_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT product_cart_fkey FOREIGN KEY (cart_user_id)
        REFERENCES public.cart (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT product_in_order_count_check CHECK (count >= 1),
    CONSTRAINT product_in_order_product_stock_check CHECK (product_stock >= 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_in_order
    OWNER to postgres;
	
------------------------------------------------------------

-- Table: public.product_info

-- DROP TABLE IF EXISTS public.product_info;

CREATE TABLE IF NOT EXISTS public.product_info
(
    product_id character varying(255) COLLATE pg_catalog."default" NOT NULL,
    category_type integer DEFAULT 0,
    create_time timestamp without time zone,
    product_description character varying(255) COLLATE pg_catalog."default",
    product_icon character varying(255) COLLATE pg_catalog."default",
    product_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    product_price numeric(19,2) NOT NULL,
    product_status integer DEFAULT 0,
    product_stock integer NOT NULL,
    update_time timestamp without time zone,
    CONSTRAINT product_info_pkey PRIMARY KEY (product_id),
    CONSTRAINT product_info_product_stock_check CHECK (product_stock >= 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_info
    OWNER to postgres;
	
-----------------------------------------------------------------

-- Table: public.tokens

-- DROP TABLE IF EXISTS public.tokens;

CREATE TABLE IF NOT EXISTS public.tokens
(
    id integer NOT NULL DEFAULT nextval('tokens_id_seq'::regclass),
    created_date timestamp without time zone,
    token character varying(255) COLLATE pg_catalog."default",
    user_id bigint NOT NULL,
    CONSTRAINT tokens_pkey PRIMARY KEY (id),
    CONSTRAINT fk2dylsfo39lgjyqml2tbe0b0ss FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tokens
    OWNER to postgres;
	
--------------------------------------------------------------------------

-- Table: public.users

-- DROP TABLE IF EXISTS public.users;

CREATE TABLE IF NOT EXISTS public.users
(
    id bigint NOT NULL,
    active boolean NOT NULL,
    address character varying(255) COLLATE pg_catalog."default",
    email character varying(255) COLLATE pg_catalog."default",
    name character varying(255) COLLATE pg_catalog."default",
    password character varying(255) COLLATE pg_catalog."default",
    phone character varying(255) COLLATE pg_catalog."default",
    role character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT users_pkey PRIMARY KEY (id),
    CONSTRAINT uk_sx468g52bpetvlad2j9y0lptc UNIQUE (email)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.users
    OWNER to postgres;
	
---------------------------------------------------------------------------

-- Table: public.wishlist

-- DROP TABLE IF EXISTS public.wishlist;

CREATE TABLE IF NOT EXISTS public.wishlist
(
    id bigint NOT NULL,
    created_date timestamp without time zone,
    user_id bigint,
    product_id character varying COLLATE pg_catalog."default",
    CONSTRAINT wishlist_pkey PRIMARY KEY (id),
    CONSTRAINT product_wish_fkey FOREIGN KEY (product_id)
        REFERENCES public.product_info (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "user_wish_Fkey" FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.wishlist
    OWNER to postgres;
	
---------------------------------------------------------------------------------------------------






--Product_Info


INSERT INTO "public"."product_category" VALUES (2147483641, 'Java', 0, '2022-06-23 23:03:26', '2022-06-23 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483642, 'C', 1, '2022-06-23 23:03:26', '2022-06-23 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483643, 'Python', 2, '2022-06-23 23:03:26', '2022-06-23 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483644, 'C++', 3, '2022-06-23 23:03:26', '2022-06-23 23:03:26');


--Product


INSERT INTO "public"."product_info" VALUES ('IF001', 0, '2022-06-23 23:03:26','
Daniel Liang teaches concepts of problem-solving and object-oriented programming using a fundamentals-first approach.','https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQlGKaHa9VO2DqkbkAEmCdRqLPVoSqvNABW7ii49LB26QeFow3udCyClLFpN8In-HVdhC2ssPZyzcg&usqp=CAc','Introduction to JAVA Programming 9th Edition  (English, Paperback, Y. Daniel Liang)', 760.00, 0, 22, '2022-06-23 23:03:26');

INSERT INTO "public"."product_info" VALUES ('IF002', 0, '2022-06-23 23:03:26', 'Experienced Java programmers new to reactive programming and those who may have some experience with reactive programming new to Java.','https://images-na.ssl-images-amazon.com/images/I/51GVfzclSuL._SX328_BO1,204,203,200_.jpg', ' Reactive Java Programming', 1650.00, 0, 60, '2022-06-23 23:03:26');

INSERT INTO "public"."product_info" VALUES ('IF003', 0, '2022-06-23 23:03:26','By emphasizing the application of computer programming not only in success stories in the software industry but also in familiar scenarios in physical and biological science, engineering.', 'https://rukminim1.flixcart.com/image/416/416/book/1/2/1/introduction-to-programming-in-java-an-interdisciplinary-original-imadz4gectqk3hpd.jpeg?q=70', 'Introduction to Programming in Java : An Interdisciplinary Approach ', 450.00, 0, 40, '2022-06-23 23:03:26');

INSERT INTO "public"."product_info" VALUES ('IF004', 0, '2022-06-23 23:03:26','This textbook was written with two primary objectives. The first is to introduce the Java programming language. Java is a practical and still-current software tool.', 'https://images-na.ssl-images-amazon.com/images/I/517NGG1oLNL._SX331_BO1,204,203,200_.jpg', 'Getting Inside Java - Beginners Guide: Programming with Java by Prem Kumar', 150.00, 0, 40, '2022-06-23 23:03:26');

INSERT INTO "public"."product_info" VALUES ('IF005', 0, '2022-06-23 23:03:26','Walter Savitch received his Ph.D. degree in Mathematics from the University of California at Berkeley in 1969. Since that time he has been on the faculty at the University of California ', 'https://images-na.ssl-images-amazon.com/images/I/51gPpqSACmL._SX364_BO1,204,203,200_.jpg', 'Java: An Introduction to Problem Solving and Programming', 250.00, 0, 40, '2022-06-23 23:03:26');




INSERT INTO "public"."product_info" VALUES ('WS001', 1, '2022-06-23 23:03:26', 'The new edition of this classic book has been thoroughly revamped but remains faithful to the principles that have established it as a favourite amongst students, teachers and software professionals round the world. ', 'https://images-na.ssl-images-amazon.com/images/I/412GfwQATXL._SX347_BO1,204,203,200_.jpg', 'Let Us C : Authentic guide to C programming language ', 100.00, 0, 22, '2022-06-23 23:03:26');

INSERT INTO "public"."product_info" VALUES ('WS002', 1, '2022-06-23 23:03:26', 'Beginner or novice programmers who wish to learn the C programming language. No prior programming experience is required.', 'https://images-na.ssl-images-amazon.com/images/I/41-ukHz9g4L._SX348_BO1,204,203,200_.jpg', 'Modern C for Absolute Beginners: A Friendly Introduction to the C Programming Language', 1850.00, 0, 10, '2022-06-23 23:03:26');

INSERT INTO "public"."product_info" VALUES ('WS003', 1, '2022-06-23 23:03:26', 'A detailed introduction to the C programming language for experienced programmers.Effective C will teach you how to write professional, secure, and portable C code that will stand the test of time and help strengthen the foundation of the computing world.', 'https://images-na.ssl-images-amazon.com/images/I/51yzJtKjcNL._SX376_BO1,204,203,200_.jpg', 'Effective C: An Introduction to Professional C Programming', 2050.00, 0, 50, '2022-06-23 23:03:26');

INSERT INTO "public"."product_info" VALUES ('WS004', 1, '2022-06-23 23:03:26', 'This ebook is the first authorized digital version of Kernighan and Ritchie’s 1988 classic, The C Programming Language (2nd Ed.). One of the best-selling programming books published in the last fifty years.', 'https://m.media-amazon.com/images/I/41vUdzcR8cL.jpg', 'C Programming Language 2nd Edition, Kindle Edition', 145.00, 0, 50,'2022-06-23 23:03:26');

INSERT INTO "public"."product_info" VALUES ('WS005', 1, '2022-06-23 23:03:26', 'Written as a practical Packt book brimming with engaging examples, C Programming for Arduino will help those new to the amazing open source electronic platform so that they can start developing some great projects from the very start.', 'https://images-na.ssl-images-amazon.com/images/I/41JZ+zzGJyL._SX404_BO1,204,203,200_.jpg', 'C Programming for Arduino', 445.00, 0, 50, '2022-06-23 23:03:26');


INSERT INTO "public"."product_info" VALUES ('PA001', 2, '2022-06-23 23:03:26', 'This book will ease you in gently by introducing you to the software you will need to create your programs: a command-line interface, which allows you to use Python in interactive mode, and a text editor for writing script.', 'https://images-na.ssl-images-amazon.com/images/I/41EJFAI-N2S._SX331_BO1,204,203,200_.jpg', 'Python Crash Course', 73.00, 0, 45, '2022-06-23 23:03:26');

INSERT INTO "public"."product_info" VALUES ('PA002', 2, '2022-06-23 23:03:26', 'There''s almost no type of project that Python can''t make better. From creating apps to building complex web sites to sorting big data, Python provides a way to get the work done.', 'https://images-na.ssl-images-amazon.com/images/I/512StzAwp8L._SX383_BO1,204,203,200_.jpg', 'Python All-in-One For Dummies ', 550.00, 0, 53, '2022-06-23 23:03:26');

INSERT INTO "public"."product_info" VALUES ('PA003', 2, '2022-06-23 23:03:26', 'Explore all aspects of programming with Python in this comprehensive resource. Expert programmer Martin Brown guides you from the fundamentals of using modules through the use of advanced objectorientation classes.', 'https://images-na.ssl-images-amazon.com/images/I/51y1U5JPfyL._SX417_BO1,204,203,200_.jpg', 'Python: The Complete Reference  ', 455.00, 0, 70, '2022-06-23 23:03:26');

INSERT INTO "public"."product_info" VALUES ('PA004', 2, '2022-06-23 23:03:26', 'This book is useful for students and IT professionals who want to make their career in the field of Machine Learning and Data Science.', 'https://images-na.ssl-images-amazon.com/images/I/51HQhrN7GHL._SX371_BO1,204,203,200_.jpg', 'Machine Learning in Data Science Using Python ', 650.00, 0, 70, '2022-06-23 23:03:26');

INSERT INTO "public"."product_info" VALUES ('PA005', 2, '2022-06-23 23:03:26', 'This book on python was written keeping in view of the beginners who struggle to get good content and programs for learning in a very lucid manner. The main objective of writing this book was to clear the concepts from basics to advanced levels.', 'https://images-na.ssl-images-amazon.com/images/I/513iVNJgc2L._SX411_BO1,204,203,200_.jpg', 'Programming Techniques using Python: Have Fun and Play with Basic and Advanced Core Python ', 495.00, 0, 70, '2022-06-23 23:03:26');



INSERT INTO "public"."product_info" VALUES ('AF001', 3, '2022-06-23 23:03:26', 'Object-oriented programming with C++, 8th edition is here with some valuable updates. The new edition helps students to assess their learning by answering questions based on learning outcomes.', 'https://images-na.ssl-images-amazon.com/images/I/41sbWdpTgRL._SX371_BO1,204,203,200_.jpg', 'Object-Oriented Programming with C++ ', 350.00, 0, 39, '2022-06-23 23:03:26');

INSERT INTO "public"."product_info" VALUES ('AF002', 3, '2022-06-23 23:03:26', 'C++ Programming: An Object-Oriented Approach in the first edition offers to its students a strong pedagogical foundation and complements a course designed to teach object-oriented programming using the syntax of the C++ language.','https://images-na.ssl-images-amazon.com/images/I/414eZHHAEoL._SX373_BO1,204,203,200_.jpg', 'C++ Programming:An Object-Oriented Approach', 560.00, 0, 75, '2022-06-23 23:03:26');

INSERT INTO "public"."product_info" VALUES ('AF003', 3, '2022-06-23 23:03:26', 'C++ Primer, Fourth Edition has been completely revised and rewritten to conform to today''s C++ usage. Students new to C++ will find a clear and practically organized introduction to the language enhanced by numerous pedagogical aids.', 'https://images-na.ssl-images-amazon.com/images/I/41+ZFpMiz9L._SY498_BO1,204,203,200_.jpg', 'C++ Primer ', 482.00, 0, 20, '2022-06-23 23:03:26');




------------------------------------------------------------------------------------------------------------------------

--Users

INSERT INTO "public"."users" VALUES (2147483645, true, 'Plot 2, Shivaji Nagar, Benagluru', 'admin@eshop.com', 'Admin', '$2a$10$LiBwO43TpKU0sZgCxNkWJueq2lqxoUBsX2Wclzk8JQ3Ejb9MWu2Xy', '1234567890', 'ROLE_MANAGER');
