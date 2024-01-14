

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

CREATE TABLE public.lotnisko (
    lotnisko_id integer NOT NULL,
    nazwa_lotniska character varying NOT NULL,
    miasto character varying NOT NULL,
    kod_lotniska character varying NOT NULL,
    kraj character varying NOT NULL
);


--
-- TOC entry 231 (class 1259 OID 24590)
-- Name: Airports; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."Airports" AS
 SELECT nazwa_lotniska,
    miasto,
    kraj
   FROM public.lotnisko;



--
-- TOC entry 222 (class 1259 OID 16577)
-- Name: przyloty; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.przyloty (
    przylot_id integer NOT NULL,
    lotnisko_id integer NOT NULL,
    samolot_id integer NOT NULL,
    data_przylotu date NOT NULL,
    godzina_przylotu time without time zone NOT NULL,
    numer_rejsu integer NOT NULL
);


--
-- TOC entry 233 (class 1259 OID 24598)
-- Name: arrivals_airports; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.arrivals_airports AS
 SELECT p.przylot_id,
    p.samolot_id,
    p.data_przylotu,
    p.godzina_przylotu,
    p.numer_rejsu,
    l.nazwa_lotniska,
    l.kraj
   FROM (public.przyloty p
     JOIN public.lotnisko l ON ((p.lotnisko_id = l.lotnisko_id)));


--
-- TOC entry 220 (class 1259 OID 16567)
-- Name: odloty; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.odloty (
    odlot_id integer NOT NULL,
    samolot_id integer NOT NULL,
    lotnisko_id integer NOT NULL,
    data_odlotu date NOT NULL,
    godzina_odlotu time without time zone NOT NULL,
    numer_rejsu integer NOT NULL
);

--
-- TOC entry 232 (class 1259 OID 24594)
-- Name: departures_airports; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.departures_airports AS
 SELECT o.odlot_id,
    o.samolot_id,
    o.data_odlotu,
    o.godzina_odlotu,
    o.numer_rejsu,
    l.nazwa_lotniska,
    l.kraj
   FROM (public.odloty o
     JOIN public.lotnisko l ON ((o.lotnisko_id = l.lotnisko_id)));




--
-- TOC entry 224 (class 1259 OID 16647)
-- Name: lotnisko_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lotnisko_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



--
-- TOC entry 227 (class 1259 OID 16652)
-- Name: odlot_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.odlot_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




--
-- TOC entry 218 (class 1259 OID 16553)
-- Name: pas_startowy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pas_startowy (
    pas_startowy_id integer NOT NULL,
    lotnisko_id integer NOT NULL,
    nazwa_pasa character varying NOT NULL
);



-- TOC entry 225 (class 1259 OID 16648)
-- Name: pas_startowy_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pas_startowy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



--
-- TOC entry 219 (class 1259 OID 16560)
-- Name: pasazer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pasazer (
    pasazer_id integer NOT NULL,
    samolot_id integer NOT NULL,
    lotnisko_id integer NOT NULL,
    imie character varying NOT NULL,
    narodowosc character varying NOT NULL,
    pesel character varying NOT NULL,
    nazwisko character varying NOT NULL,
    numer_rejsu integer NOT NULL
);

--
-- TOC entry 229 (class 1259 OID 16655)
-- Name: pasazer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pasazer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



--
-- TOC entry 221 (class 1259 OID 16572)
-- Name: pasazer_odlot; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pasazer_odlot (
    pasazer_odlot_id integer NOT NULL,
    pasazer_id integer NOT NULL,
    samolot_id integer NOT NULL,
    lotnisko_id integer NOT NULL,
    odlot_id integer NOT NULL
);


--
-- TOC entry 223 (class 1259 OID 16582)
-- Name: pasazer_przylot; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pasazer_przylot (
    pasazer_przylot_id integer NOT NULL,
    przylot_id integer NOT NULL,
    lotnisko_id integer NOT NULL,
    samolot_id integer NOT NULL,
    pasazer_id integer NOT NULL
);




--
-- TOC entry 234 (class 1259 OID 24602)
-- Name: passengers_airports; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.passengers_airports AS
 SELECT p.pasazer_id,
    p.imie,
    p.nazwisko,
    p.narodowosc,
    p.pesel,
    p.numer_rejsu,
    l.nazwa_lotniska
   FROM (public.pasazer p
     JOIN public.lotnisko l ON ((p.lotnisko_id = l.lotnisko_id)));



--
-- TOC entry 217 (class 1259 OID 16546)
-- Name: pracownik; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pracownik (
    pracownik_id integer NOT NULL,
    lotnisko_id integer NOT NULL,
    imie character varying NOT NULL,
    nazwisko character varying NOT NULL,
    narodowosc character varying NOT NULL,
    pesel character varying NOT NULL
);



--
-- TOC entry 230 (class 1259 OID 16656)
-- Name: pracownik_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pracownik_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 228 (class 1259 OID 16654)
-- Name: przylot_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.przylot_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 215 (class 1259 OID 16532)
-- Name: samolot; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.samolot (
    samolot_id integer NOT NULL,
    numer_seryjny integer NOT NULL,
    model_samolotu character varying NOT NULL,
    linia_lotnicza character varying NOT NULL
);

--
-- TOC entry 226 (class 1259 OID 16651)
-- Name: samolot_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.samolot_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



--
-- TOC entry 4866 (class 0 OID 16539)
-- Dependencies: 216
-- Data for Name: lotnisko; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.lotnisko VALUES (1, 'John F. Kennedy International Airport', 'New York', 'JFK', 'USA');
INSERT INTO public.lotnisko VALUES (2, 'Heathrow Airport', 'London', 'LHR', 'UK');
INSERT INTO public.lotnisko VALUES (3, 'Charles de Gaulle Airport', 'Paris', 'CDG', 'France');
INSERT INTO public.lotnisko VALUES (4, 'Los Angeles International Airport', 'Los Angeles', 'LAX', 'USA');
INSERT INTO public.lotnisko VALUES (5, 'Frankfurt Airport', 'Frankfurt', 'FRA', 'Germany');
INSERT INTO public.lotnisko VALUES (6, 'Tokyo Haneda Airport', 'Tokyo', 'HND', 'Japan');
INSERT INTO public.lotnisko VALUES (7, 'Sydney Kingsford Smith Airport', 'Sydney', 'SYD', 'Australia');
INSERT INTO public.lotnisko VALUES (8, 'Dubai International Airport', 'Dubai', 'DXB', 'UAE');
INSERT INTO public.lotnisko VALUES (9, 'Beijing Capital International Airport', 'Beijing', 'PEK', 'China');
INSERT INTO public.lotnisko VALUES (10, 'Singapore Changi Airport', 'Singapore', 'SIN', 'Singapore');
INSERT INTO public.lotnisko VALUES (11, 'Incheon International Airport', 'Seoul', 'ICN', 'South Korea');
INSERT INTO public.lotnisko VALUES (12, 'Hamad International Airport', 'Doha', 'DOH', 'Qatar');
INSERT INTO public.lotnisko VALUES (13, 'O''Hare International Airport', 'Chicago', 'ORD', 'USA');
INSERT INTO public.lotnisko VALUES (14, 'Denver International Airport', 'Denver', 'DEN', 'USA');
INSERT INTO public.lotnisko VALUES (15, 'Zurich Airport', 'Zurich', 'ZRH', 'Switzerland');
INSERT INTO public.lotnisko VALUES (16, 'Hong Kong International Airport', 'Hong Kong', 'HKG', 'Hong Kong');
INSERT INTO public.lotnisko VALUES (17, 'Munich Airport', 'Munich', 'MUC', 'Germany');
INSERT INTO public.lotnisko VALUES (18, 'Adolfo Suárez Madrid–Barajas Airport', 'Madrid', 'MAD', 'Spain');
INSERT INTO public.lotnisko VALUES (19, 'Toronto Pearson International Airport', 'Toronto', 'YYZ', 'Canada');
INSERT INTO public.lotnisko VALUES (20, 'Sydney Airport', 'Sydney', 'SYD', 'Australia');


--
-- TOC entry 4870 (class 0 OID 16567)
-- Dependencies: 220
-- Data for Name: odloty; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.odloty VALUES (1, 1, 1, '2023-12-01', '12:00:00', 101);
INSERT INTO public.odloty VALUES (2, 2, 2, '2023-12-02', '13:30:00', 102);
INSERT INTO public.odloty VALUES (3, 3, 3, '2023-12-03', '15:00:00', 103);
INSERT INTO public.odloty VALUES (4, 4, 4, '2023-12-04', '16:30:00', 104);
INSERT INTO public.odloty VALUES (5, 5, 5, '2023-12-05', '18:00:00', 105);
INSERT INTO public.odloty VALUES (6, 6, 6, '2023-12-06', '19:30:00', 106);
INSERT INTO public.odloty VALUES (7, 7, 7, '2023-12-07', '21:00:00', 107);
INSERT INTO public.odloty VALUES (8, 8, 8, '2023-12-08', '22:30:00', 108);
INSERT INTO public.odloty VALUES (9, 9, 9, '2023-12-09', '00:00:00', 109);
INSERT INTO public.odloty VALUES (10, 10, 10, '2023-12-10', '01:30:00', 110);
INSERT INTO public.odloty VALUES (11, 11, 11, '2023-12-11', '03:00:00', 111);
INSERT INTO public.odloty VALUES (12, 12, 12, '2023-12-12', '04:30:00', 112);
INSERT INTO public.odloty VALUES (13, 13, 13, '2023-12-13', '06:00:00', 113);
INSERT INTO public.odloty VALUES (14, 14, 14, '2023-12-14', '07:30:00', 114);
INSERT INTO public.odloty VALUES (15, 15, 15, '2023-12-15', '09:00:00', 115);
INSERT INTO public.odloty VALUES (16, 16, 16, '2023-12-16', '10:30:00', 116);
INSERT INTO public.odloty VALUES (17, 17, 17, '2023-12-17', '12:00:00', 117);
INSERT INTO public.odloty VALUES (18, 18, 18, '2023-12-18', '13:30:00', 118);
INSERT INTO public.odloty VALUES (19, 19, 19, '2023-12-19', '15:00:00', 119);
INSERT INTO public.odloty VALUES (20, 20, 20, '2023-12-20', '16:30:00', 120);
INSERT INTO public.odloty VALUES (21, 21, 1, '2023-12-21', '18:00:00', 121);
INSERT INTO public.odloty VALUES (22, 22, 2, '2023-12-22', '19:30:00', 122);
INSERT INTO public.odloty VALUES (23, 23, 3, '2023-12-23', '21:00:00', 123);
INSERT INTO public.odloty VALUES (24, 24, 4, '2023-12-24', '22:30:00', 124);
INSERT INTO public.odloty VALUES (25, 25, 5, '2023-12-25', '00:00:00', 125);
INSERT INTO public.odloty VALUES (26, 26, 6, '2023-12-26', '01:30:00', 126);
INSERT INTO public.odloty VALUES (27, 27, 7, '2023-12-27', '03:00:00', 127);
INSERT INTO public.odloty VALUES (28, 28, 8, '2023-12-28', '04:30:00', 128);
INSERT INTO public.odloty VALUES (29, 29, 9, '2023-12-29', '06:00:00', 129);
INSERT INTO public.odloty VALUES (30, 30, 10, '2023-12-30', '07:30:00', 130);


--
-- TOC entry 4868 (class 0 OID 16553)
-- Dependencies: 218
-- Data for Name: pas_startowy; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pas_startowy VALUES (1, 1, 'Pasażerski A');
INSERT INTO public.pas_startowy VALUES (2, 2, 'Cargo B');
INSERT INTO public.pas_startowy VALUES (3, 3, 'Pasażerski C');
INSERT INTO public.pas_startowy VALUES (4, 4, 'Cargo D');
INSERT INTO public.pas_startowy VALUES (5, 5, 'Pasażerski E');
INSERT INTO public.pas_startowy VALUES (6, 6, 'Cargo F');
INSERT INTO public.pas_startowy VALUES (7, 7, 'Pasażerski G');
INSERT INTO public.pas_startowy VALUES (8, 8, 'Cargo H');
INSERT INTO public.pas_startowy VALUES (9, 9, 'Pasażerski I');
INSERT INTO public.pas_startowy VALUES (10, 10, 'Cargo J');
INSERT INTO public.pas_startowy VALUES (11, 11, 'Pasażerski K');
INSERT INTO public.pas_startowy VALUES (12, 12, 'Cargo L');
INSERT INTO public.pas_startowy VALUES (13, 13, 'Pasażerski M');
INSERT INTO public.pas_startowy VALUES (14, 14, 'Cargo N');
INSERT INTO public.pas_startowy VALUES (15, 15, 'Pasażerski O');
INSERT INTO public.pas_startowy VALUES (16, 16, 'Cargo P');
INSERT INTO public.pas_startowy VALUES (17, 17, 'Pasażerski Q');
INSERT INTO public.pas_startowy VALUES (18, 18, 'Cargo R');
INSERT INTO public.pas_startowy VALUES (19, 19, 'Pasażerski S');
INSERT INTO public.pas_startowy VALUES (20, 20, 'Cargo T');


--
-- TOC entry 4869 (class 0 OID 16560)
-- Dependencies: 219
-- Data for Name: pasazer; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pasazer VALUES (1, 1, 1, 'Sophia', 'USA', '12345678901', 'Johnson', 101);
INSERT INTO public.pasazer VALUES (2, 2, 2, 'Liam', 'USA', '23456789012', 'Williams', 102);
INSERT INTO public.pasazer VALUES (3, 3, 3, 'Emma', 'Wielka Brytania', '34567890123', 'Jones', 103);
INSERT INTO public.pasazer VALUES (4, 4, 4, 'Olivia', 'Wielka Brytania', '45678901234', 'Brown', 104);
INSERT INTO public.pasazer VALUES (5, 5, 5, 'Noah', 'Australia', '56789012345', 'Miller', 105);
INSERT INTO public.pasazer VALUES (6, 6, 6, 'Ava', 'Kanada', '67890123456', 'Davis', 106);
INSERT INTO public.pasazer VALUES (7, 7, 7, 'Isabella', 'USA', '78901234567', 'Garcia', 107);
INSERT INTO public.pasazer VALUES (8, 8, 8, 'Sophia', 'Hiszpania', '89012345678', 'Rodriguez', 108);
INSERT INTO public.pasazer VALUES (9, 9, 9, 'Liam', 'Meksyk', '90123456789', 'Lopez', 109);
INSERT INTO public.pasazer VALUES (10, 10, 10, 'Oliver', 'Meksyk', '01234567890', 'Lee', 110);
INSERT INTO public.pasazer VALUES (11, 11, 11, 'Lucas', 'Chiny', '12345678901', 'Chen', 111);
INSERT INTO public.pasazer VALUES (12, 12, 12, 'Ethan', 'Chiny', '23456789012', 'Wang', 112);
INSERT INTO public.pasazer VALUES (13, 13, 13, 'Alexander', 'Chiny', '34567890123', 'Kim', 113);
INSERT INTO public.pasazer VALUES (14, 14, 14, 'Daniel', 'Korea Południowa', '45678901234', 'Park', 114);
INSERT INTO public.pasazer VALUES (15, 15, 15, 'Ethan', 'Korea Południowa', '56789012345', 'Jung', 115);
INSERT INTO public.pasazer VALUES (16, 16, 16, 'Olivia', 'Korea Południowa', '67890123456', 'Lee', 116);
INSERT INTO public.pasazer VALUES (17, 17, 17, 'Amelia', 'Korea Południowa', '78901234567', 'Choi', 117);
INSERT INTO public.pasazer VALUES (18, 18, 18, 'Sophia', 'Korea Południowa', '89012345678', 'Yoo', 118);
INSERT INTO public.pasazer VALUES (19, 19, 19, 'Mia', 'Korea Południowa', '90123456789', 'Smith', 119);
INSERT INTO public.pasazer VALUES (20, 20, 20, 'Liam', 'USA', '01234567890', 'Johnson', 120);
INSERT INTO public.pasazer VALUES (21, 1, 1, 'Amelia', 'USA', '12345678901', 'Johnson', 121);
INSERT INTO public.pasazer VALUES (22, 2, 2, 'Elijah', 'Wielka Brytania', '23456789012', 'Williams', 122);
INSERT INTO public.pasazer VALUES (23, 3, 3, 'Grace', 'Wielka Brytania', '34567890123', 'Jones', 123);
INSERT INTO public.pasazer VALUES (24, 4, 4, 'Aiden', 'Australia', '45678901234', 'Brown', 124);
INSERT INTO public.pasazer VALUES (25, 5, 5, 'Ella', 'Kanada', '56789012345', 'Miller', 125);
INSERT INTO public.pasazer VALUES (26, 6, 6, 'Carter', 'USA', '67890123456', 'Davis', 126);
INSERT INTO public.pasazer VALUES (27, 7, 7, 'Scarlett', 'Hiszpania', '78901234567', 'Garcia', 127);
INSERT INTO public.pasazer VALUES (28, 8, 8, 'Liam', 'Meksyk', '89012345678', 'Rodriguez', 128);
INSERT INTO public.pasazer VALUES (29, 9, 9, 'Amelia', 'Meksyk', '90123456789', 'Lopez', 129);
INSERT INTO public.pasazer VALUES (30, 10, 10, 'James', 'Chiny', '01234567890', 'Lee', 200);
INSERT INTO public.pasazer VALUES (31, 11, 11, 'Sophia', 'Chiny', '12345678901', 'Chen', 201);
INSERT INTO public.pasazer VALUES (32, 12, 12, 'Liam', 'Chiny', '23456789012', 'Wang', 202);
INSERT INTO public.pasazer VALUES (33, 13, 13, 'Emma', 'Korea Południowa', '34567890123', 'Kim', 203);
INSERT INTO public.pasazer VALUES (34, 14, 14, 'Olivia', 'Korea Południowa', '45678901234', 'Park', 204);
INSERT INTO public.pasazer VALUES (35, 15, 15, 'Ethan', 'Korea Południowa', '56789012345', 'Jung', 205);
INSERT INTO public.pasazer VALUES (36, 16, 16, 'Ella', 'Korea Południowa', '67890123456', 'Lee', 206);
INSERT INTO public.pasazer VALUES (37, 17, 17, 'Liam', 'Korea Południowa', '78901234567', 'Choi', 207);
INSERT INTO public.pasazer VALUES (38, 18, 18, 'Grace', 'Korea Południowa', '89012345678', 'Yoo', 208);
INSERT INTO public.pasazer VALUES (40, 20, 20, 'Ella', 'USA', '01234567890', 'Johnson', 210);
INSERT INTO public.pasazer VALUES (39, 19, 19, 'Oliver', 'Korea Południowa', '90123456789', 'Smith', 209);
INSERT INTO public.pasazer VALUES (41, 1, 1, 'Mia', 'USA', '12345678901', 'Johnson', 211);
INSERT INTO public.pasazer VALUES (42, 2, 2, 'Liam', 'Wielka Brytania', '23456789012', 'Williams', 212);
INSERT INTO public.pasazer VALUES (43, 3, 3, 'Amelia', 'Wielka Brytania', '34567890123', 'Jones', 213);
INSERT INTO public.pasazer VALUES (44, 4, 4, 'Elijah', 'Australia', '45678901234', 'Brown', 214);
INSERT INTO public.pasazer VALUES (45, 5, 5, 'Ella', 'Kanada', '56789012345', 'Miller', 215);
INSERT INTO public.pasazer VALUES (46, 6, 6, 'Carter', 'USA', '67890123456', 'Davis', 216);
INSERT INTO public.pasazer VALUES (47, 7, 7, 'Scarlett', 'Hiszpania', '78901234567', 'Garcia', 217);
INSERT INTO public.pasazer VALUES (48, 8, 8, 'Liam', 'Meksyk', '89012345678', 'Rodriguez', 218);
INSERT INTO public.pasazer VALUES (49, 9, 9, 'Amelia', 'Meksyk', '90123456789', 'Lopez', 219);
INSERT INTO public.pasazer VALUES (50, 10, 10, 'James', 'Chiny', '01234567890', 'Lee', 220);
INSERT INTO public.pasazer VALUES (51, 11, 11, 'Sophia', 'Chiny', '12345678901', 'Chen', 221);
INSERT INTO public.pasazer VALUES (52, 12, 12, 'Liam', 'Chiny', '23456789012', 'Wang', 222);
INSERT INTO public.pasazer VALUES (53, 13, 13, 'Emma', 'Korea Południowa', '34567890123', 'Kim', 223);
INSERT INTO public.pasazer VALUES (54, 14, 14, 'Olivia', 'Korea Południowa', '45678901234', 'Park', 224);
INSERT INTO public.pasazer VALUES (55, 15, 15, 'Ethan', 'Korea Południowa', '56789012345', 'Jung', 225);
INSERT INTO public.pasazer VALUES (56, 16, 16, 'Ella', 'Korea Południowa', '67890123456', 'Lee', 226);
INSERT INTO public.pasazer VALUES (57, 17, 17, 'Liam', 'Korea Południowa', '78901234567', 'Choi', 227);
INSERT INTO public.pasazer VALUES (58, 18, 18, 'Grace', 'Korea Południowa', '89012345678', 'Yoo', 228);
INSERT INTO public.pasazer VALUES (59, 19, 19, 'Oliver', 'Korea Południowa', '90123456789', 'Smith', 229);
INSERT INTO public.pasazer VALUES (60, 20, 20, 'Ella', 'USA', '01234567890', 'Johnson', 230);


--
-- TOC entry 4871 (class 0 OID 16572)
-- Dependencies: 221
-- Data for Name: pasazer_odlot; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4873 (class 0 OID 16582)
-- Dependencies: 223
-- Data for Name: pasazer_przylot; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4867 (class 0 OID 16546)
-- Dependencies: 217
-- Data for Name: pracownik; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pracownik VALUES (1, 1, 'James', 'Smith', 'USA', '12345678901');
INSERT INTO public.pracownik VALUES (2, 2, 'Sophia', 'Johnson', 'USA', '23456789012');
INSERT INTO public.pracownik VALUES (3, 3, 'Liam', 'Williams', 'Wielka Brytania', '34567890123');
INSERT INTO public.pracownik VALUES (4, 4, 'Emma', 'Jones', 'Wielka Brytania', '45678901234');
INSERT INTO public.pracownik VALUES (5, 5, 'Olivia', 'Brown', 'Australia', '56789012345');
INSERT INTO public.pracownik VALUES (6, 6, 'Noah', 'Miller', 'Kanada', '67890123456');
INSERT INTO public.pracownik VALUES (7, 7, 'Ava', 'Davis', 'USA', '78901234567');
INSERT INTO public.pracownik VALUES (8, 8, 'Isabella', 'Garcia', 'Hiszpania', '89012345678');
INSERT INTO public.pracownik VALUES (9, 9, 'Sophia', 'Rodriguez', 'Meksyk', '90123456789');
INSERT INTO public.pracownik VALUES (10, 10, 'Oliver', 'Lopez', 'Meksyk', '01234567890');
INSERT INTO public.pracownik VALUES (11, 11, 'Lucas', 'Lee', 'Chiny', '12345678901');
INSERT INTO public.pracownik VALUES (12, 12, 'Ethan', 'Chen', 'Chiny', '23456789012');
INSERT INTO public.pracownik VALUES (13, 13, 'Alexander', 'Wang', 'Chiny', '34567890123');
INSERT INTO public.pracownik VALUES (14, 14, 'Daniel', 'Kim', 'Korea Południowa', '45678901234');
INSERT INTO public.pracownik VALUES (15, 15, 'Ethan', 'Park', 'Korea Południowa', '56789012345');
INSERT INTO public.pracownik VALUES (16, 16, 'Olivia', 'Jung', 'Korea Południowa', '67890123456');
INSERT INTO public.pracownik VALUES (17, 17, 'Amelia', 'Lee', 'Korea Południowa', '78901234567');
INSERT INTO public.pracownik VALUES (18, 18, 'Sophia', 'Choi', 'Korea Południowa', '89012345678');
INSERT INTO public.pracownik VALUES (19, 19, 'Mia', 'Yoo', 'Korea Południowa', '90123456789');
INSERT INTO public.pracownik VALUES (20, 20, 'Liam', 'Smith', 'USA', '01234567890');
INSERT INTO public.pracownik VALUES (21, 1, 'Amelia', 'Johnson', 'USA', '12345678901');
INSERT INTO public.pracownik VALUES (22, 2, 'Elijah', 'Williams', 'Wielka Brytania', '23456789012');
INSERT INTO public.pracownik VALUES (23, 3, 'Grace', 'Jones', 'Wielka Brytania', '34567890123');
INSERT INTO public.pracownik VALUES (24, 4, 'Aiden', 'Brown', 'Australia', '45678901234');
INSERT INTO public.pracownik VALUES (25, 5, 'Ella', 'Miller', 'Kanada', '56789012345');
INSERT INTO public.pracownik VALUES (26, 6, 'Carter', 'Davis', 'USA', '67890123456');
INSERT INTO public.pracownik VALUES (27, 7, 'Scarlett', 'Garcia', 'Hiszpania', '78901234567');
INSERT INTO public.pracownik VALUES (28, 8, 'Liam', 'Rodriguez', 'Meksyk', '89012345678');
INSERT INTO public.pracownik VALUES (29, 9, 'Amelia', 'Lopez', 'Meksyk', '90123456789');
INSERT INTO public.pracownik VALUES (30, 10, 'James', 'Lee', 'Chiny', '01234567890');
INSERT INTO public.pracownik VALUES (31, 11, 'Sophia', 'Chen', 'Chiny', '12345678901');
INSERT INTO public.pracownik VALUES (32, 12, 'Liam', 'Wang', 'Chiny', '23456789012');
INSERT INTO public.pracownik VALUES (33, 13, 'Emma', 'Kim', 'Korea Południowa', '34567890123');
INSERT INTO public.pracownik VALUES (34, 14, 'Olivia', 'Park', 'Korea Południowa', '45678901234');
INSERT INTO public.pracownik VALUES (35, 15, 'Ethan', 'Jung', 'Korea Południowa', '56789012345');
INSERT INTO public.pracownik VALUES (36, 16, 'Ella', 'Lee', 'Korea Południowa', '67890123456');
INSERT INTO public.pracownik VALUES (37, 17, 'Liam', 'Choi', 'Korea Południowa', '78901234567');
INSERT INTO public.pracownik VALUES (38, 18, 'Grace', 'Yoo', 'Korea Południowa', '89012345678');
INSERT INTO public.pracownik VALUES (39, 19, 'Oliver', 'Smith', 'USA', '90123456789');
INSERT INTO public.pracownik VALUES (40, 20, 'Ella', 'Johnson', 'USA', '01234567890');
INSERT INTO public.pracownik VALUES (41, 1, 'Mia', 'Williams', 'Wielka Brytania', '12345678901');
INSERT INTO public.pracownik VALUES (42, 2, 'Liam', 'Jones', 'Wielka Brytania', '23456789012');
INSERT INTO public.pracownik VALUES (43, 3, 'Amelia', 'Brown', 'Australia', '34567890123');
INSERT INTO public.pracownik VALUES (44, 4, 'Elijah', 'Miller', 'Kanada', '45678901234');
INSERT INTO public.pracownik VALUES (45, 5, 'Ella', 'Davis', 'USA', '56789012345');
INSERT INTO public.pracownik VALUES (46, 6, 'Carter', 'Garcia', 'Hiszpania', '67890123456');
INSERT INTO public.pracownik VALUES (47, 7, 'Scarlett', 'Rodriguez', 'Meksyk', '78901234567');
INSERT INTO public.pracownik VALUES (48, 8, 'Liam', 'Lopez', 'Meksyk', '89012345678');
INSERT INTO public.pracownik VALUES (49, 9, 'Amelia', 'Lee', 'Chiny', '90123456789');
INSERT INTO public.pracownik VALUES (50, 10, 'James', 'Chen', 'Chiny', '01234567890');
INSERT INTO public.pracownik VALUES (51, 11, 'Sophia', 'Wang', 'Chiny', '12345678901');
INSERT INTO public.pracownik VALUES (52, 12, 'Liam', 'Kim', 'Korea Południowa', '23456789012');
INSERT INTO public.pracownik VALUES (53, 13, 'Emma', 'Park', 'Korea Południowa', '34567890123');
INSERT INTO public.pracownik VALUES (54, 14, 'Olivia', 'Jung', 'Korea Południowa', '45678901234');
INSERT INTO public.pracownik VALUES (55, 15, 'Ethan', 'Lee', 'Korea Południowa', '56789012345');
INSERT INTO public.pracownik VALUES (56, 16, 'Ella', 'Choi', 'Korea Południowa', '67890123456');
INSERT INTO public.pracownik VALUES (57, 17, 'Liam', 'Yoo', 'Korea Południowa', '78901234567');
INSERT INTO public.pracownik VALUES (58, 18, 'Grace', 'Smith', 'USA', '89012345678');
INSERT INTO public.pracownik VALUES (59, 19, 'Oliver', 'Johnson', 'USA', '90123456789');
INSERT INTO public.pracownik VALUES (60, 20, 'Ella', 'Williams', 'Wielka Brytania', '01234567890');
INSERT INTO public.pracownik VALUES (61, 1, 'Mia', 'Jones', 'Wielka Brytania', '12345678901');
INSERT INTO public.pracownik VALUES (62, 2, 'Liam', 'Brown', 'Australia', '23456789012');
INSERT INTO public.pracownik VALUES (63, 3, 'Amelia', 'Miller', 'Kanada', '34567890123');
INSERT INTO public.pracownik VALUES (64, 4, 'Elijah', 'Davis', 'USA', '45678901234');
INSERT INTO public.pracownik VALUES (65, 5, 'Ella', 'Garcia', 'Hiszpania', '56789012345');
INSERT INTO public.pracownik VALUES (66, 6, 'Carter', 'Rodriguez', 'Meksyk', '67890123456');
INSERT INTO public.pracownik VALUES (67, 7, 'Scarlett', 'Lopez', 'Meksyk', '78901234567');
INSERT INTO public.pracownik VALUES (68, 8, 'Liam', 'Lee', 'Chiny', '89012345678');
INSERT INTO public.pracownik VALUES (69, 9, 'Amelia', 'Chen', 'Chiny', '90123456789');
INSERT INTO public.pracownik VALUES (70, 10, 'James', 'Wang', 'Chiny', '01234567890');
INSERT INTO public.pracownik VALUES (71, 11, 'Sophia', 'Kim', 'Korea Południowa', '12345678901');
INSERT INTO public.pracownik VALUES (72, 12, 'Liam', 'Park', 'Korea Południowa', '23456789012');
INSERT INTO public.pracownik VALUES (73, 13, 'Emma', 'Jung', 'Korea Południowa', '34567890123');
INSERT INTO public.pracownik VALUES (74, 14, 'Olivia', 'Lee', 'Korea Południowa', '45678901234');
INSERT INTO public.pracownik VALUES (75, 15, 'Ethan', 'Choi', 'Korea Południowa', '56789012345');
INSERT INTO public.pracownik VALUES (76, 16, 'Ella', 'Yoo', 'Korea Południowa', '67890123456');
INSERT INTO public.pracownik VALUES (77, 17, 'Liam', 'Smith', 'USA', '78901234567');
INSERT INTO public.pracownik VALUES (78, 18, 'Grace', 'Johnson', 'USA', '89012345678');
INSERT INTO public.pracownik VALUES (79, 19, 'Oliver', 'Williams', 'Wielka Brytania', '90123456789');
INSERT INTO public.pracownik VALUES (80, 20, 'Ella', 'Jones', 'Wielka Brytania', '01234567890');


--
-- TOC entry 4872 (class 0 OID 16577)
-- Dependencies: 222
-- Data for Name: przyloty; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.przyloty VALUES (1, 1, 1, '2023-12-01', '12:00:00', 201);
INSERT INTO public.przyloty VALUES (2, 2, 2, '2023-12-02', '13:30:00', 202);
INSERT INTO public.przyloty VALUES (3, 3, 3, '2023-12-03', '15:00:00', 203);
INSERT INTO public.przyloty VALUES (4, 4, 4, '2023-12-04', '16:30:00', 204);
INSERT INTO public.przyloty VALUES (5, 5, 5, '2023-12-05', '18:00:00', 205);
INSERT INTO public.przyloty VALUES (6, 6, 6, '2023-12-06', '19:30:00', 206);
INSERT INTO public.przyloty VALUES (7, 7, 7, '2023-12-07', '21:00:00', 207);
INSERT INTO public.przyloty VALUES (8, 8, 8, '2023-12-08', '22:30:00', 208);
INSERT INTO public.przyloty VALUES (9, 9, 9, '2023-12-09', '00:00:00', 209);
INSERT INTO public.przyloty VALUES (10, 10, 10, '2023-12-10', '01:30:00', 210);
INSERT INTO public.przyloty VALUES (11, 11, 11, '2023-12-11', '03:00:00', 211);
INSERT INTO public.przyloty VALUES (12, 12, 12, '2023-12-12', '04:30:00', 212);
INSERT INTO public.przyloty VALUES (13, 13, 13, '2023-12-13', '06:00:00', 213);
INSERT INTO public.przyloty VALUES (14, 14, 14, '2023-12-14', '07:30:00', 214);
INSERT INTO public.przyloty VALUES (15, 15, 15, '2023-12-15', '09:00:00', 215);
INSERT INTO public.przyloty VALUES (16, 16, 16, '2023-12-16', '10:30:00', 216);
INSERT INTO public.przyloty VALUES (17, 17, 17, '2023-12-17', '12:00:00', 217);
INSERT INTO public.przyloty VALUES (18, 18, 18, '2023-12-18', '13:30:00', 218);
INSERT INTO public.przyloty VALUES (19, 19, 19, '2023-12-19', '15:00:00', 219);
INSERT INTO public.przyloty VALUES (20, 20, 20, '2023-12-20', '16:30:00', 220);
INSERT INTO public.przyloty VALUES (21, 1, 21, '2023-12-21', '18:00:00', 221);
INSERT INTO public.przyloty VALUES (22, 2, 22, '2023-12-22', '19:30:00', 222);
INSERT INTO public.przyloty VALUES (23, 3, 23, '2023-12-23', '21:00:00', 223);
INSERT INTO public.przyloty VALUES (24, 4, 24, '2023-12-24', '22:30:00', 224);
INSERT INTO public.przyloty VALUES (25, 5, 25, '2023-12-25', '00:00:00', 225);
INSERT INTO public.przyloty VALUES (26, 6, 26, '2023-12-26', '01:30:00', 226);
INSERT INTO public.przyloty VALUES (27, 7, 27, '2023-12-27', '03:00:00', 227);
INSERT INTO public.przyloty VALUES (28, 8, 28, '2023-12-28', '04:30:00', 228);
INSERT INTO public.przyloty VALUES (29, 9, 29, '2023-12-29', '06:00:00', 229);
INSERT INTO public.przyloty VALUES (30, 10, 30, '2023-12-30', '07:30:00', 230);


--
-- TOC entry 4865 (class 0 OID 16532)
-- Dependencies: 215
-- Data for Name: samolot; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.samolot VALUES (1, 12345, 'Boeing 737', 'Lufthansa');
INSERT INTO public.samolot VALUES (2, 54321, 'Airbus A320', 'British Airways');
INSERT INTO public.samolot VALUES (3, 98765, 'Boeing 777', 'Emirates');
INSERT INTO public.samolot VALUES (4, 11111, 'Airbus A380', 'Qatar Airways');
INSERT INTO public.samolot VALUES (5, 22222, 'Boeing 747', 'Singapore Airlines');
INSERT INTO public.samolot VALUES (6, 33333, 'Airbus A330', 'Cathay Pacific');
INSERT INTO public.samolot VALUES (7, 44444, 'Boeing 787', 'ANA');
INSERT INTO public.samolot VALUES (8, 55555, 'Airbus A350', 'Qantas');
INSERT INTO public.samolot VALUES (9, 66666, 'Embraer E190', 'KLM');
INSERT INTO public.samolot VALUES (10, 77777, 'Bombardier CRJ900', 'Air Canada');
INSERT INTO public.samolot VALUES (11, 88888, 'ATR 72', 'Turkish Airlines');
INSERT INTO public.samolot VALUES (12, 99999, 'Cessna 172', 'Private Jet');
INSERT INTO public.samolot VALUES (13, 12121, 'Boeing 767', 'Delta Air Lines');
INSERT INTO public.samolot VALUES (14, 23232, 'Airbus A319', 'Air France');
INSERT INTO public.samolot VALUES (15, 34343, 'Embraer E170', 'Alitalia');
INSERT INTO public.samolot VALUES (16, 45454, 'Bombardier Q400', 'Scandinavian Airlines');
INSERT INTO public.samolot VALUES (17, 56565, 'ATR 42', 'Swiss International Air Lines');
INSERT INTO public.samolot VALUES (18, 67676, 'Cessna 208', 'FedEx');
INSERT INTO public.samolot VALUES (19, 78787, 'Boeing 757', 'American Airlines');
INSERT INTO public.samolot VALUES (20, 89898, 'Airbus A321', 'United Airlines');
INSERT INTO public.samolot VALUES (21, 90909, 'Boeing 777', 'Singapore Airlines');
INSERT INTO public.samolot VALUES (22, 10101, 'Airbus A380', 'Qantas');
INSERT INTO public.samolot VALUES (23, 11111, 'Boeing 747', 'Emirates');
INSERT INTO public.samolot VALUES (24, 12121, 'Airbus A330', 'British Airways');
INSERT INTO public.samolot VALUES (25, 13131, 'Boeing 787', 'Cathay Pacific');
INSERT INTO public.samolot VALUES (26, 14141, 'Airbus A350', 'Qatar Airways');
INSERT INTO public.samolot VALUES (27, 15151, 'Embraer E190', 'KLM');
INSERT INTO public.samolot VALUES (28, 16161, 'Bombardier CRJ900', 'Lufthansa');
INSERT INTO public.samolot VALUES (29, 17171, 'ATR 72', 'Turkish Airlines');
INSERT INTO public.samolot VALUES (30, 18181, 'Cessna 172', 'Private Jet');


--
-- TOC entry 4886 (class 0 OID 0)
-- Dependencies: 224
-- Name: lotnisko_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lotnisko_id_seq', 20, true);


--
-- TOC entry 4887 (class 0 OID 0)
-- Dependencies: 227
-- Name: odlot_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.odlot_id_seq', 30, true);


--
-- TOC entry 4888 (class 0 OID 0)
-- Dependencies: 225
-- Name: pas_startowy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pas_startowy_id_seq', 20, true);


--
-- TOC entry 4889 (class 0 OID 0)
-- Dependencies: 229
-- Name: pasazer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pasazer_id_seq', 720, true);


--
-- TOC entry 4890 (class 0 OID 0)
-- Dependencies: 230
-- Name: pracownik_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pracownik_id_seq', 80, true);


--
-- TOC entry 4891 (class 0 OID 0)
-- Dependencies: 228
-- Name: przylot_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.przylot_id_seq', 30, true);


--
-- TOC entry 4892 (class 0 OID 0)
-- Dependencies: 226
-- Name: samolot_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.samolot_id_seq', 30, true);


--
-- TOC entry 4691 (class 2606 OID 16545)
-- Name: lotnisko lotnisko_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lotnisko
ADD CONSTRAINT lotnisko_pk PRIMARY KEY (lotnisko_id);


--
-- TOC entry 4699 (class 2606 OID 16571)
-- Name: odloty odloty_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.odloty
    ADD CONSTRAINT odloty_pk PRIMARY KEY (odlot_id, samolot_id, lotnisko_id);


--
-- TOC entry 4695 (class 2606 OID 16559)
-- Name: pas_startowy pas_startowy_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pas_startowy
    ADD CONSTRAINT pas_startowy_pk PRIMARY KEY (pas_startowy_id, lotnisko_id);


--
-- TOC entry 4701 (class 2606 OID 16576)
-- Name: pasazer_odlot pasazer_odlot_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pasazer_odlot
    ADD CONSTRAINT pasazer_odlot_pk PRIMARY KEY (pasazer_odlot_id, pasazer_id, samolot_id, lotnisko_id, odlot_id);


--
-- TOC entry 4697 (class 2606 OID 16566)
-- Name: pasazer pasazer_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pasazer
    ADD CONSTRAINT pasazer_pk PRIMARY KEY (pasazer_id, samolot_id, lotnisko_id);


--
-- TOC entry 4705 (class 2606 OID 16586)
-- Name: pasazer_przylot pasazer_przylot_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pasazer_przylot
    ADD CONSTRAINT pasazer_przylot_pk PRIMARY KEY (pasazer_przylot_id, przylot_id, lotnisko_id, samolot_id, pasazer_id);


--
-- TOC entry 4693 (class 2606 OID 16552)
-- Name: pracownik pracownik_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pracownik
    ADD CONSTRAINT pracownik_pk PRIMARY KEY (pracownik_id, lotnisko_id);


--
-- TOC entry 4703 (class 2606 OID 16581)
-- Name: przyloty przyloty_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.przyloty
    ADD CONSTRAINT przyloty_pk PRIMARY KEY (przylot_id, lotnisko_id, samolot_id);


--
-- TOC entry 4689 (class 2606 OID 16538)
-- Name: samolot samolot_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.samolot
    ADD CONSTRAINT samolot_pk PRIMARY KEY (samolot_id);


--
-- TOC entry 4710 (class 2606 OID 16607)
-- Name: odloty lotnisko_odloty_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.odloty
    ADD CONSTRAINT lotnisko_odloty_fk FOREIGN KEY (lotnisko_id) REFERENCES public.lotnisko(lotnisko_id);


--
-- TOC entry 4707 (class 2606 OID 16617)
-- Name: pas_startowy lotnisko_pas_startowy_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pas_startowy
    ADD CONSTRAINT lotnisko_pas_startowy_fk FOREIGN KEY (lotnisko_id) REFERENCES public.lotnisko(lotnisko_id);


--
-- TOC entry 4708 (class 2606 OID 16612)
-- Name: pasazer lotnisko_pasazer_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pasazer
    ADD CONSTRAINT lotnisko_pasazer_fk FOREIGN KEY (lotnisko_id) REFERENCES public.lotnisko(lotnisko_id);


--
-- TOC entry 4706 (class 2606 OID 16622)
-- Name: pracownik lotnisko_pracownik_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pracownik
    ADD CONSTRAINT lotnisko_pracownik_fk FOREIGN KEY (lotnisko_id) REFERENCES public.lotnisko(lotnisko_id);


--
-- TOC entry 4714 (class 2606 OID 16602)
-- Name: przyloty lotnisko_przyloty_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.przyloty
    ADD CONSTRAINT lotnisko_przyloty_fk FOREIGN KEY (lotnisko_id) REFERENCES public.lotnisko(lotnisko_id);


--
-- TOC entry 4712 (class 2606 OID 16637)
-- Name: pasazer_odlot odloty_pasazer_odlot_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pasazer_odlot
    ADD CONSTRAINT odloty_pasazer_odlot_fk FOREIGN KEY (odlot_id, samolot_id, lotnisko_id) REFERENCES public.odloty(odlot_id, samolot_id, lotnisko_id);


--
-- TOC entry 4713 (class 2606 OID 16627)
-- Name: pasazer_odlot pasazer_pasazer_odlot_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pasazer_odlot
    ADD CONSTRAINT pasazer_pasazer_odlot_fk FOREIGN KEY (pasazer_id, samolot_id, lotnisko_id) REFERENCES public.pasazer(pasazer_id, samolot_id, lotnisko_id);


--
-- TOC entry 4716 (class 2606 OID 16632)
-- Name: pasazer_przylot pasazer_pasazer_przylot_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pasazer_przylot
    ADD CONSTRAINT pasazer_pasazer_przylot_fk FOREIGN KEY (pasazer_id, samolot_id, lotnisko_id) REFERENCES public.pasazer(pasazer_id, samolot_id, lotnisko_id);


--
-- TOC entry 4717 (class 2606 OID 16642)
-- Name: pasazer_przylot przyloty_pasazer_przylot_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pasazer_przylot
    ADD CONSTRAINT przyloty_pasazer_przylot_fk FOREIGN KEY (przylot_id, lotnisko_id, samolot_id) REFERENCES public.przyloty(przylot_id, lotnisko_id, samolot_id);


--
-- TOC entry 4711 (class 2606 OID 16592)
-- Name: odloty samolot_odloty_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.odloty
    ADD CONSTRAINT samolot_odloty_fk FOREIGN KEY (samolot_id) REFERENCES public.samolot(samolot_id);


--
-- TOC entry 4709 (class 2606 OID 16597)
-- Name: pasazer samolot_pasazer_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pasazer
    ADD CONSTRAINT samolot_pasazer_fk FOREIGN KEY (samolot_id) REFERENCES public.samolot(samolot_id);


--
-- TOC entry 4715 (class 2606 OID 16587)
-- Name: przyloty samolot_przyloty_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.przyloty
    ADD CONSTRAINT samolot_przyloty_fk FOREIGN KEY (samolot_id) REFERENCES public.samolot(samolot_id);


CREATE VIEW public.widok_przyloty_lotniska_pasazerowie AS
SELECT 
    p.przylot_id,
    p.data_przylotu,
    p.godzina_przylotu,
    p.numer_rejsu,
    l.nazwa_lotniska,
    l.miasto,
    l.kod_lotniska,
    l.kraj,
    pas.imie AS imie_pasazera,
    pas.nazwisko AS nazwisko_pasazera,
    pas.narodowosc AS narodowosc_pasazera
FROM przyloty p
JOIN lotnisko l ON p.lotnisko_id = l.lotnisko_id
LEFT JOIN pasazer_przylot pp ON p.przylot_id = pp.przylot_id
LEFT JOIN pasazer pas ON pp.pasazer_id = pas.pasazer_id;


CREATE VIEW public.widok_odloty_lotniska_samoloty_pracownicy AS
SELECT 
    o.odlot_id,
    o.data_odlotu,
    o.godzina_odlotu,
    o.numer_rejsu,
    l.nazwa_lotniska,
    l.miasto,
    l.kod_lotniska,
    l.kraj,
    s.numer_seryjny AS numer_seryjny_samolotu,
    s.model_samolotu,
    s.linia_lotnicza,
    pr.imie AS imie_pracownika,
    pr.nazwisko AS nazwisko_pracownika,
    pr.narodowosc AS narodowosc_pracownika
FROM odloty o
JOIN lotnisko l ON o.lotnisko_id = l.lotnisko_id
JOIN samolot s ON o.samolot_id = s.samolot_id
LEFT JOIN pracownik pr ON s.samolot_id = pr.lotnisko_id;

CREATE VIEW public.widok_pasazerowie_lotniska_odloty_przyloty AS
SELECT 
    pas.pasazer_id,
    pas.imie,
    pas.nazwisko,
    pas.narodowosc,
    l.nazwa_lotniska,
    l.miasto,
    l.kod_lotniska,
    l.kraj,
    o.data_odlotu,
    o.godzina_odlotu,
    o.numer_rejsu AS numer_rejsu_odlotu,
    p.data_przylotu,
    p.godzina_przylotu,
    p.numer_rejsu AS numer_rejsu_przylotu
FROM pasazer pas
JOIN pasazer_odlot po ON pas.pasazer_id = po.pasazer_id
JOIN odloty o ON po.odlot_id = o.odlot_id
JOIN lotnisko l ON o.lotnisko_id = l.lotnisko_id
LEFT JOIN pasazer_przylot pp ON pas.pasazer_id = pp.pasazer_id
LEFT JOIN przyloty p ON pp.przylot_id = p.przylot_id;


