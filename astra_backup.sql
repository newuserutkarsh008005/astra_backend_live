--
-- PostgreSQL database dump
--

\restrict IJVmfJ7j41o4WS3uZYcgW1puqGs2Gx0gA3rPvfTytsOLvDhek8Mw0jEm7xWFz48

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.4 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: PaymentStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."PaymentStatus" AS ENUM (
    'PENDING',
    'SUCCESS',
    'FAILED',
    'REFUNDED'
);


ALTER TYPE public."PaymentStatus" OWNER TO postgres;

--
-- Name: bookingStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."bookingStatus" AS ENUM (
    'CONFIRMED',
    'COMPLETED',
    'CANCELLED',
    'PENDING'
);


ALTER TYPE public."bookingStatus" OWNER TO postgres;

--
-- Name: slotStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."slotStatus" AS ENUM (
    'AVAILABLE',
    'RESERVED',
    'BOOKED'
);


ALTER TYPE public."slotStatus" OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Astrologer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Astrologer" (
    id text NOT NULL,
    email text NOT NULL,
    pass text NOT NULL
);


ALTER TABLE public."Astrologer" OWNER TO postgres;

--
-- Name: Booking; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Booking" (
    id text NOT NULL,
    "userId" text,
    "serviceId" text NOT NULL,
    "paymentId" text,
    "slotId" text NOT NULL,
    "meetingroomId" text,
    "recordingUrl" text,
    "transcriptUrl" text,
    status public."bookingStatus" DEFAULT 'PENDING'::public."bookingStatus" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "reportUrl" text
);


ALTER TABLE public."Booking" OWNER TO postgres;

--
-- Name: Payment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Payment" (
    id text NOT NULL,
    "userId" text NOT NULL,
    "serviceId" text NOT NULL,
    "razorpayOrderId" text NOT NULL,
    "razorpayPaymentId" text NOT NULL,
    amount double precision NOT NULL,
    status public."PaymentStatus" DEFAULT 'PENDING'::public."PaymentStatus" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Payment" OWNER TO postgres;

--
-- Name: Service; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Service" (
    id text NOT NULL,
    title text NOT NULL,
    category text NOT NULL,
    description text NOT NULL,
    price double precision NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updateAt" timestamp(3) without time zone NOT NULL,
    image text NOT NULL
);


ALTER TABLE public."Service" OWNER TO postgres;

--
-- Name: Slot; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Slot" (
    id text NOT NULL,
    start text NOT NULL,
    "end" text NOT NULL,
    status public."slotStatus" DEFAULT 'AVAILABLE'::public."slotStatus" NOT NULL,
    "reservedByUserId" text,
    "reservedUntill" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    date timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Slot" OWNER TO postgres;

--
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    id text NOT NULL,
    "auth0Id" text NOT NULL,
    email text NOT NULL,
    name text NOT NULL,
    phone text,
    "profileImage" text,
    "dateOfBirth" timestamp(3) without time zone,
    "birthTime" text,
    "birthPlace" text,
    gender text,
    "isPremium" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- Data for Name: Astrologer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Astrologer" (id, email, pass) FROM stdin;
1	astraadmin@astra.com	ddeaa5d4c863a321a6e00011b9583ce217ecdaddffb377168013b20bd5f131b7
\.


--
-- Data for Name: Booking; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Booking" (id, "userId", "serviceId", "paymentId", "slotId", "meetingroomId", "recordingUrl", "transcriptUrl", status, "createdAt", "updatedAt", "reportUrl") FROM stdin;
5fdaf6f5-0a06-4c11-9a8f-aad1ea28856b	\N	e47d5b1b-f6d2-4b9a-84d1-4056f742eff6	\N	310db173-6795-4d53-a2e8-989b5db3b001	\N	\N	\N	PENDING	2026-06-30 15:30:06.534	2026-06-30 15:30:06.534	\N
1f398880-ae77-450d-aebf-59c43769cfe7	\N	cc44be88-36da-4840-9c6a-0bc9bfea71e6	\N	05cd4560-7cb8-4092-8dd5-fdacc7a37cbe	\N	\N	\N	PENDING	2026-06-30 16:04:46.349	2026-06-30 16:04:46.349	\N
3f8ea271-db3b-459f-b8a9-7135b4c71010	\N	cc44be88-36da-4840-9c6a-0bc9bfea71e6	\N	04b3f09c-db21-4039-b453-3a10d0d29435	\N	\N	\N	PENDING	2026-06-30 16:06:02.603	2026-06-30 16:06:02.603	\N
0c9d8ee4-b82d-4262-ba76-a1f0477acc92	\N	94ab8191-d260-4a92-a49a-37a4cb42dab1	\N	d15bb7a5-8844-4a9c-896e-d205a1a0bb2d	\N	\N	\N	PENDING	2026-07-02 14:23:15.79	2026-07-02 14:23:15.79	\N
08397135-67ac-4365-b0aa-2c36959ded18	\N	94ab8191-d260-4a92-a49a-37a4cb42dab1	\N	93379c22-c4ae-4d50-b33a-94b263a96156	\N	\N	\N	PENDING	2026-07-02 14:25:35.063	2026-07-02 14:25:35.063	\N
187d01d0-de71-4bc4-8e9c-de911793f1e3	\N	d35f6541-c9b8-442b-bc82-22d06f8568e6	\N	fbc29e92-6c30-4ba9-b9b8-a8e2af014061	\N	\N	\N	PENDING	2026-06-30 16:17:08.902	2026-06-30 16:17:08.902	\N
c6cac821-6b92-49cf-bd28-158ce59e7881	\N	d35f6541-c9b8-442b-bc82-22d06f8568e6	\N	1d09bc49-b7ef-4cad-9dc2-bf688dd34c3a	\N	\N	\N	PENDING	2026-06-30 16:17:46.925	2026-06-30 16:17:46.925	\N
3074ea79-09a6-41cb-bd50-46230881e308	\N	d35f6541-c9b8-442b-bc82-22d06f8568e6	\N	4ad1ee59-f034-4a07-b6c1-4175630e93b5	\N	\N	\N	PENDING	2026-06-30 16:24:08.955	2026-06-30 16:24:08.955	\N
4eea723b-fc67-49f7-bd54-1fd1e504428e	\N	d35f6541-c9b8-442b-bc82-22d06f8568e6	\N	5d4ffea1-61bd-403b-a940-d4ca407706b4	\N	\N	\N	PENDING	2026-06-30 16:29:16.084	2026-06-30 16:29:16.084	\N
c8dea1ca-8694-4575-95b6-fb37b5d9e153	\N	d35f6541-c9b8-442b-bc82-22d06f8568e6	\N	546f64fa-a137-4fdc-b9aa-9ff7fc1aae62	\N	\N	\N	PENDING	2026-06-30 16:32:43.069	2026-06-30 16:32:43.069	\N
92c0a0a7-830a-440a-845a-4886af19accb	\N	0a70612a-ef03-4e35-8b96-2db260f3be84	\N	e5fbbc29-4443-4b25-b480-0734574f70aa	\N	\N	\N	PENDING	2026-06-30 16:59:39.051	2026-06-30 16:59:39.051	\N
bd6819ec-2b51-426f-8ba6-4ce75f09ef2d	\N	94ab8191-d260-4a92-a49a-37a4cb42dab1	\N	206246c6-a2b9-4e3a-9186-02c577ef6944	\N	\N	\N	PENDING	2026-07-02 14:44:44.026	2026-07-02 14:44:44.026	\N
8bac3c00-94bc-4833-9f39-b6d6f7a8217b	\N	0a70612a-ef03-4e35-8b96-2db260f3be84	\N	b580650e-c1ec-4a3d-a57f-14d495376f82	\N	\N	\N	PENDING	2026-06-30 17:00:57.792	2026-06-30 17:00:57.792	\N
ed9c1d9b-c901-4ec0-ab57-25d63998f7b2	\N	0a70612a-ef03-4e35-8b96-2db260f3be84	\N	875a4eee-9fcf-45d0-848f-5547221aa462	\N	\N	\N	PENDING	2026-06-30 17:01:25.311	2026-06-30 17:01:25.311	\N
f81ceace-8f7e-4cf5-b827-f64d856239f8	6f0ec6b9-54c7-499f-a9b0-497ba3d8320c	e47d5b1b-f6d2-4b9a-84d1-4056f742eff6	\N	cc51e999-46d1-49ff-a735-b22a0f4a1b92	\N	\N	\N	CANCELLED	2026-07-02 18:57:13.93	2026-07-02 18:57:44.903	\N
4df8e271-a1b7-4655-8b8e-4fc7967cb50e	6f0ec6b9-54c7-499f-a9b0-497ba3d8320c	94ab8191-d260-4a92-a49a-37a4cb42dab1	\N	d3dba7d1-771f-4f73-80bc-acbe3347cccb	\N	\N	\N	CANCELLED	2026-07-02 19:01:49.683	2026-07-02 19:02:13.691	\N
9506b851-4eda-4ae7-9cce-dd37b2631a37	\N	0a70612a-ef03-4e35-8b96-2db260f3be84	11cd9f23-22f4-4b86-9ee8-e653705691e3	d9b15bf6-2e42-409f-8eba-b30c3c6c6ba2	\N	\N	\N	CONFIRMED	2026-06-30 17:03:46.278	2026-06-30 17:05:46.032	\N
ff81c62a-e3f4-4ede-8de0-30fbfa6574e1	\N	0a70612a-ef03-4e35-8b96-2db260f3be84	e3b45b94-b34b-45a8-ab47-1efd506a0761	0deae9a4-97a3-4977-b61d-f21c39357b5e	\N	\N	\N	CONFIRMED	2026-06-30 17:06:57.89	2026-06-30 17:07:24.215	\N
51b5eed5-91e7-4527-84c5-e8a1fec9f7ce	\N	0a70612a-ef03-4e35-8b96-2db260f3be84	\N	604c0752-ce1c-42f0-ac43-db73802bc5d5	\N	\N	\N	PENDING	2026-06-30 17:15:45.252	2026-06-30 17:15:45.252	\N
583eafce-981f-427b-9ba4-77b7b00dd448	\N	0a70612a-ef03-4e35-8b96-2db260f3be84	33907abd-d588-4a4e-8c5a-9f96257abec2	61c927ba-70a5-47f7-a122-fb08e522577f	\N	\N	\N	CONFIRMED	2026-06-30 17:41:18.727	2026-06-30 17:41:42.656	\N
5a0b5ef3-0389-4393-ab9f-7c935678d7d4	\N	cc44be88-36da-4840-9c6a-0bc9bfea71e6	\N	0f7eefda-8f43-4ea8-b285-33c8ec858e9a	\N	\N	\N	PENDING	2026-07-01 13:12:10.744	2026-07-01 13:12:10.744	\N
416366b3-ced5-4852-8113-745ee72e8100	\N	94ab8191-d260-4a92-a49a-37a4cb42dab1	\N	5c2000b2-fd92-43ff-a505-84b1b190cd8d	\N	\N	\N	PENDING	2026-07-02 13:51:23.756	2026-07-02 13:51:23.756	\N
3af322c2-4dc5-4e9a-b5a4-b658acc4d4cf	\N	94ab8191-d260-4a92-a49a-37a4cb42dab1	\N	982428ab-196a-4c12-a321-189d9cdee92b	\N	\N	\N	PENDING	2026-07-02 13:56:55.732	2026-07-02 13:56:55.732	\N
8a88df12-94b0-4e5e-bf32-2909d8101b65	7907c9ac-242c-4391-818e-48ff977fae8f	b5786be4-5669-4d0f-932c-dcfdfc625c0b	cc39c43b-e9bd-4dea-9d03-760b34c1246f	d3dba7d1-771f-4f73-80bc-acbe3347cccb	astra-test-room	\N	\N	CONFIRMED	2026-07-03 03:52:44.805	2026-07-03 03:53:08.137	\N
4a3747a9-c0be-45f7-83de-389805a230f8	\N	94ab8191-d260-4a92-a49a-37a4cb42dab1	\N	cef41393-1422-401d-ace0-e35567a0d2ed	\N	\N	\N	PENDING	2026-07-02 14:06:00.253	2026-07-02 14:06:00.253	\N
ccdb9689-3eb9-46d5-b2b7-ed7c6174a583	7907c9ac-242c-4391-818e-48ff977fae8f	94ab8191-d260-4a92-a49a-37a4cb42dab1	ad8dffaf-31b1-4dba-b08f-ec52fb45455b	8feb309e-9c9e-462a-8b36-5f2fa95cd15f	astra-9c544ab7-0378-49c7-8372-815b4e4864b3	\N	\N	COMPLETED	2026-07-03 05:39:01.901	2026-07-06 04:41:36.187	\N
449d0700-843f-4430-b2a2-eb128963aec4	d107e41e-3d8c-404c-bc19-e83509c0879a	25458d07-065a-4f1c-9be6-f834036e949b	\N	e5fbbc29-4443-4b25-b480-0734574f70aa	NEW_MEETING_ROOM_ID	\N	\N	COMPLETED	2026-07-06 08:51:54.396	2026-07-06 04:32:25.996	\N
ae378fd8-1027-4297-99aa-4a4ebf392b95	7907c9ac-242c-4391-818e-48ff977fae8f	3a7a7916-4451-4801-9bde-546bea37ac75	4b5cb7df-5a59-4d0b-96ed-7cc4d714d5a1	82120039-4ca5-47a6-9536-fe27952a1214	astra-98fbe1c1-2ece-4914-8ba4-f37a55d92af1	\N	\N	COMPLETED	2026-07-04 09:48:23.745	2026-07-06 04:40:00.602	\N
f06420b3-912f-4b89-9446-d38c763cc2d0	d107e41e-3d8c-404c-bc19-e83509c0879a	94ab8191-d260-4a92-a49a-37a4cb42dab1	cc03234f-8508-483c-9a96-6631c0445ecd	69ee4bc5-4fb6-4925-9194-c3b6e5c1d79e	astra-e4288dd5-3355-473a-91d3-895c9e73461b	\N	\N	COMPLETED	2026-07-06 04:58:52.884	2026-07-06 05:00:57.04	\N
dee669d7-3299-4de5-9433-cffc95f36134	d107e41e-3d8c-404c-bc19-e83509c0879a	94ab8191-d260-4a92-a49a-37a4cb42dab1	519ba716-d9c7-4be4-92dc-656e99e21eb7	62667f08-8d46-4f6c-bbf3-0286e5e17738	astra-c6f01e59-281a-48b1-8786-1288deaa00b8	\N	\N	COMPLETED	2026-07-06 04:52:12.228	2026-07-06 04:52:41.99	\N
1a82e22d-68f1-4c8a-8b4f-c1d935603cb4	\N	94ab8191-d260-4a92-a49a-37a4cb42dab1	\N	347b34da-5d31-4f40-bed0-ea0ff3f221a9	\N	\N	\N	PENDING	2026-07-02 14:08:26.633	2026-07-02 14:08:26.633	\N
6516db97-28e8-4abe-9876-93ce429fc41f	d107e41e-3d8c-404c-bc19-e83509c0879a	43e25745-187c-4e30-a665-893bb1ef53f2	ebe83f91-7a12-419d-820a-d1d782d3ff1e	7605ebd1-8789-4d83-b18a-68b5abfbb52a	astra-9e9fc302-f87f-455f-82b3-71d50dcd2428	\N	\N	CONFIRMED	2026-07-06 05:31:41.974	2026-07-06 05:32:22.042	\N
25b4f1c5-9c47-4489-b4ce-ac2f8cb6f8e3	7907c9ac-242c-4391-818e-48ff977fae8f	dd13ca09-0b48-4d64-a2d1-f33d8366e973	\N	b65019c1-eb8b-4c8e-82e1-e1769c6dbe69	\N	\N	\N	PENDING	2026-07-06 05:49:57.362	2026-07-06 05:49:57.362	\N
6d9fb8ca-3b2b-433c-834b-0771ef7ac8a9	\N	94ab8191-d260-4a92-a49a-37a4cb42dab1	\N	77b074f1-beaf-47af-85c9-523379336722	\N	\N	\N	PENDING	2026-07-02 14:17:04.647	2026-07-02 14:17:04.647	\N
3407ee3b-bc3f-48ac-a97b-c3b5829e9046	\N	94ab8191-d260-4a92-a49a-37a4cb42dab1	\N	5431b52f-661d-48fa-aa31-7ba2a85fc241	\N	\N	\N	PENDING	2026-07-02 14:24:12.251	2026-07-02 14:24:12.251	\N
96e5769b-64b2-419f-ba88-005515d6cb61	\N	94ab8191-d260-4a92-a49a-37a4cb42dab1	\N	9df09277-cb0f-4554-8b86-5c796328b6ac	\N	\N	\N	PENDING	2026-07-02 14:43:38.381	2026-07-02 14:43:38.381	\N
2a49f221-7cb9-4901-b6b6-c5903b3c9680	\N	94ab8191-d260-4a92-a49a-37a4cb42dab1	\N	ea19de3c-d82c-4eed-a482-04a915046600	\N	\N	\N	PENDING	2026-07-02 14:19:14.602	2026-07-02 14:19:14.602	\N
6846a81c-3c15-430a-8b36-d6862256272d	6f0ec6b9-54c7-499f-a9b0-497ba3d8320c	e47d5b1b-f6d2-4b9a-84d1-4056f742eff6	6ca576cf-9e4a-4bd6-bd7c-5ce61bfc8ebd	b580650e-c1ec-4a3d-a57f-14d495376f82	\N	\N	\N	CONFIRMED	2026-07-02 18:47:41.462	2026-07-02 18:49:32.085	\N
2721ac3f-a979-40c7-82a3-448200b0d400	6f0ec6b9-54c7-499f-a9b0-497ba3d8320c	94ab8191-d260-4a92-a49a-37a4cb42dab1	\N	cc51e999-46d1-49ff-a735-b22a0f4a1b92	\N	\N	\N	CANCELLED	2026-07-02 18:59:56.484	2026-07-02 19:00:24.065	\N
ae03ae63-48a2-4575-a3c2-8d015c3782d3	6f0ec6b9-54c7-499f-a9b0-497ba3d8320c	94ab8191-d260-4a92-a49a-37a4cb42dab1	\N	d3dba7d1-771f-4f73-80bc-acbe3347cccb	\N	\N	\N	CANCELLED	2026-07-02 19:07:03.82	2026-07-02 19:07:27.372	\N
c653042d-1b99-4bbe-a072-4a0d9064e297	7907c9ac-242c-4391-818e-48ff977fae8f	94ab8191-d260-4a92-a49a-37a4cb42dab1	\N	cc51e999-46d1-49ff-a735-b22a0f4a1b92	\N	\N	\N	PENDING	2026-07-03 05:36:51.572	2026-07-03 05:36:51.572	\N
ed8b6240-c691-4c22-bdff-e9f975c81be8	7907c9ac-242c-4391-818e-48ff977fae8f	b5786be4-5669-4d0f-932c-dcfdfc625c0b	4b47147e-46d4-4740-8eed-49418f2839b0	081401eb-952b-41a8-aabd-fc24b097412b	astra-2cc92f28-677a-4280-964f-aa8872748a5b	\N	\N	CONFIRMED	2026-07-03 15:03:12.389	2026-07-03 15:03:36.816	\N
8d0bb110-60c2-4a8f-82e0-b82cda54754c	d107e41e-3d8c-404c-bc19-e83509c0879a	94ab8191-d260-4a92-a49a-37a4cb42dab1	d2a32db7-c085-4933-a1d1-d91acb8bbb7c	44199dd5-30bd-4330-973b-244a61df27a8	astra-d5e5ec46-9209-4375-8121-0570cabbe899	\N	\N	COMPLETED	2026-07-05 09:40:38.928	2026-07-06 04:40:10.136	\N
90785b5d-253a-4148-b33f-f3cf77714445	d107e41e-3d8c-404c-bc19-e83509c0879a	94ab8191-d260-4a92-a49a-37a4cb42dab1	a1dcb434-0c3b-42fb-b1ca-0437bf2a7e99	74dfc068-6b91-4919-9271-9fc881225af5	astra-df89d706-6031-4453-9be6-96225d72ff06	\N	\N	COMPLETED	2026-07-06 04:45:44.719	2026-07-06 04:50:40.43	\N
7fab7265-6c5d-459b-9f12-db0eca2a9f4d	d107e41e-3d8c-404c-bc19-e83509c0879a	94ab8191-d260-4a92-a49a-37a4cb42dab1	e07126b7-32a0-457c-870b-712c01ddea7c	e17b8db9-806b-4ac6-8861-a49b5de45805	astra-2ca7c170-e0e6-43d7-a81e-92ecc7cf695b	\N	\N	COMPLETED	2026-07-06 04:53:19.499	2026-07-06 04:53:57.14	\N
a802cfa2-cb8b-48a4-ab26-dfa30ae5b187	d107e41e-3d8c-404c-bc19-e83509c0879a	94ab8191-d260-4a92-a49a-37a4cb42dab1	77e25fee-494f-46cf-a979-ddd5f2efd2bb	8fd8c046-87f0-4f54-addc-87bda7d1c27d	astra-eb9b9363-e615-49d8-ad73-fc33a30ad528	\N	\N	COMPLETED	2026-07-06 05:01:13.794	2026-07-06 05:02:04.839	\N
cea432f9-142d-4c7e-9b9d-ece30af2eb14	d107e41e-3d8c-404c-bc19-e83509c0879a	dd13ca09-0b48-4d64-a2d1-f33d8366e973	\N	d45a0ba5-1f1a-4436-b4a6-0566af3f8340	\N	\N	\N	PENDING	2026-07-06 05:38:41.723	2026-07-06 05:38:41.723	\N
\.


--
-- Data for Name: Payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Payment" (id, "userId", "serviceId", "razorpayOrderId", "razorpayPaymentId", amount, status, "createdAt") FROM stdin;
c0eef42f-511c-4ec3-a370-52fb5fe8f198	629a4b21-8653-4f29-8ba7-d873aec148f4	b5786be4-5669-4d0f-932c-dcfdfc625c0b	order_T7U4ckINLL0mza	pay_T7U4hbOSiN6fsf	89900	SUCCESS	2026-06-29 14:43:41.537
47a78a10-98b1-4398-883d-7f7b6b25ac39	629a4b21-8653-4f29-8ba7-d873aec148f4	b5786be4-5669-4d0f-932c-dcfdfc625c0b	order_T7UMcBIywRHcBX	pay_T7UMtGIkndjjvO	89900	SUCCESS	2026-06-29 15:00:55.64
a4251fef-aec7-41c2-94ce-9c5cb2d7d168	629a4b21-8653-4f29-8ba7-d873aec148f4	94ab8191-d260-4a92-a49a-37a4cb42dab1	order_T7YVIudsOSamUX	pay_T7YVQmnUCPyUwa	129900	SUCCESS	2026-06-29 19:04:13.233
ae4662fe-b171-4238-a721-b18f5144fd45	629a4b21-8653-4f29-8ba7-d873aec148f4	94ab8191-d260-4a92-a49a-37a4cb42dab1	order_T7cECwUQVqMgyn	pay_T7cEh1jwGyLrTt	129900	SUCCESS	2026-06-29 22:42:45.873
9f8fe9de-9912-4a74-8535-b1eb894d2fd7	629a4b21-8653-4f29-8ba7-d873aec148f4	e47d5b1b-f6d2-4b9a-84d1-4056f742eff6	order_T7sdWnqa4bo4gy	pay_T7sdfogon4AEBx	99900	SUCCESS	2026-06-30 14:45:27.878
4625a916-4f15-40b0-942d-612229b10ff4	629a4b21-8653-4f29-8ba7-d873aec148f4	e47d5b1b-f6d2-4b9a-84d1-4056f742eff6	order_T7sgSWVEoWP5IM	pay_T7sgY4yQ4R21gL	99900	SUCCESS	2026-06-30 14:48:11.948
63ae37c7-991a-49b9-bcb7-296d04de5f26	629a4b21-8653-4f29-8ba7-d873aec148f4	e47d5b1b-f6d2-4b9a-84d1-4056f742eff6	order_T7sjMKFRBgukL3	pay_T7skXGnzniD6mt	99900	SUCCESS	2026-06-30 14:51:56.134
3f92b51c-5802-4185-bfca-a7a9ed79b027	629a4b21-8653-4f29-8ba7-d873aec148f4	e47d5b1b-f6d2-4b9a-84d1-4056f742eff6	order_T7smM83VvCkBbe	pay_T7smR3tOfvT8nT	99900	SUCCESS	2026-06-30 14:53:44.921
179858d5-3957-42e4-89af-a9477b0c4145	629a4b21-8653-4f29-8ba7-d873aec148f4	e47d5b1b-f6d2-4b9a-84d1-4056f742eff6	order_T7spYSUHSsQvoD	pay_T7sphxMv8bDkEV	99900	SUCCESS	2026-06-30 14:57:02.904
06b9eebc-9a70-4b31-a21c-f3d39ea54c53	629a4b21-8653-4f29-8ba7-d873aec148f4	e47d5b1b-f6d2-4b9a-84d1-4056f742eff6	order_T7srszTIHz12qy	pay_T7srzlmuaOC2el	99900	SUCCESS	2026-06-30 14:58:59.804
6bd73a61-2154-4fe6-9f3f-bf8346cb799a	629a4b21-8653-4f29-8ba7-d873aec148f4	e47d5b1b-f6d2-4b9a-84d1-4056f742eff6	order_T7sva0ssUaWdXK	pay_T7svnR58I5MLli	99900	SUCCESS	2026-06-30 15:02:43.307
0db33a9c-e81b-42c9-ac3b-01d077de038e	629a4b21-8653-4f29-8ba7-d873aec148f4	e47d5b1b-f6d2-4b9a-84d1-4056f742eff6	order_T7syeszRfMppzd	pay_T7szIgM442V1uq	99900	SUCCESS	2026-06-30 15:06:00.219
79d98929-9a36-4e6b-aad4-af611e0faded	629a4b21-8653-4f29-8ba7-d873aec148f4	e47d5b1b-f6d2-4b9a-84d1-4056f742eff6	order_T7t1FCMKvlAGfS	pay_T7t2YRwlR7YhVw	99900	SUCCESS	2026-06-30 15:09:02.347
206c8c07-1666-4693-a3f9-8bf62ac9e43e	629a4b21-8653-4f29-8ba7-d873aec148f4	d35f6541-c9b8-442b-bc82-22d06f8568e6	order_T7uKCzRUrVEYRk	pay_T7uKwtypigG7Wn	69900	SUCCESS	2026-06-30 16:25:19.046
6bb55481-7d14-4bd8-80ed-55cf364af2bb	629a4b21-8653-4f29-8ba7-d873aec148f4	d35f6541-c9b8-442b-bc82-22d06f8568e6	order_T7uTGAyz5ybDKm	pay_T7uTMWkvJEZfUS	69900	SUCCESS	2026-06-30 16:33:14.625
fbc8e2e1-02d5-472b-a27f-e81547cf3cf1	629a4b21-8653-4f29-8ba7-d873aec148f4	0a70612a-ef03-4e35-8b96-2db260f3be84	order_T7v03xR71AL0Ub	pay_T7v0DAA3Hx1gzj	99900	SUCCESS	2026-06-30 17:04:10.615
11cd9f23-22f4-4b86-9ee8-e653705691e3	629a4b21-8653-4f29-8ba7-d873aec148f4	0a70612a-ef03-4e35-8b96-2db260f3be84	order_T7v1LYWpI03so6	pay_T7v1lSoXZHc48D	99900	SUCCESS	2026-06-30 17:05:46.015
e3b45b94-b34b-45a8-ab47-1efd506a0761	629a4b21-8653-4f29-8ba7-d873aec148f4	0a70612a-ef03-4e35-8b96-2db260f3be84	order_T7v3R7bgdfA009	pay_T7v3XX5MekipjV	99900	SUCCESS	2026-06-30 17:07:24.196
33907abd-d588-4a4e-8c5a-9f96257abec2	629a4b21-8653-4f29-8ba7-d873aec148f4	0a70612a-ef03-4e35-8b96-2db260f3be84	order_T7vdibJCK8wlGh	pay_T7vdrLfooTz8jv	99900	SUCCESS	2026-06-30 17:41:42.63
6ca576cf-9e4a-4bd6-bd7c-5ce61bfc8ebd	6f0ec6b9-54c7-499f-a9b0-497ba3d8320c	e47d5b1b-f6d2-4b9a-84d1-4056f742eff6	order_T8jq4u4O9yrJnF	pay_T8jqXrf3BxspfR	99900	SUCCESS	2026-07-02 18:49:32.079
826605ce-7a00-4b9a-b178-56c1d78557ea	6f0ec6b9-54c7-499f-a9b0-497ba3d8320c	94ab8191-d260-4a92-a49a-37a4cb42dab1	order_T8kAXes8Y28nOF	pay_T8kAd4diaUdzWG	129900	FAILED	2026-07-02 19:07:27.367
cc39c43b-e9bd-4dea-9d03-760b34c1246f	7907c9ac-242c-4391-818e-48ff977fae8f	b5786be4-5669-4d0f-932c-dcfdfc625c0b	order_T8t7q339WzHTpC	pay_T8t7yptucJ34x1	89900	SUCCESS	2026-07-03 03:53:08.131
ad8dffaf-31b1-4dba-b08f-ec52fb45455b	7907c9ac-242c-4391-818e-48ff977fae8f	94ab8191-d260-4a92-a49a-37a4cb42dab1	order_T8uw6xkl2NLRww	pay_T8uwBPW41mh1po	129900	SUCCESS	2026-07-03 05:39:21.035
4b47147e-46d4-4740-8eed-49418f2839b0	7907c9ac-242c-4391-818e-48ff977fae8f	b5786be4-5669-4d0f-932c-dcfdfc625c0b	order_T94Y4FsSmxbGlw	pay_T94YDtfX4vQ4g6	89900	SUCCESS	2026-07-03 15:03:36.808
4b5cb7df-5a59-4d0b-96ed-7cc4d714d5a1	7907c9ac-242c-4391-818e-48ff977fae8f	3a7a7916-4451-4801-9bde-546bea37ac75	order_T9NidyDpuwelVE	pay_T9NimX54Mj3PDK	99900	SUCCESS	2026-07-04 09:48:47.169
d2a32db7-c085-4933-a1d1-d91acb8bbb7c	d107e41e-3d8c-404c-bc19-e83509c0879a	94ab8191-d260-4a92-a49a-37a4cb42dab1	order_T9m7a1TOIIqF9b	pay_T9m7iztw8LpzAH	129900	SUCCESS	2026-07-05 09:41:04.764
a1dcb434-0c3b-42fb-b1ca-0437bf2a7e99	d107e41e-3d8c-404c-bc19-e83509c0879a	94ab8191-d260-4a92-a49a-37a4cb42dab1	order_TA5dBTNYiLMfj5	pay_TA5dS720Mxqm10	129900	SUCCESS	2026-07-06 04:46:15.59
519ba716-d9c7-4be4-92dc-656e99e21eb7	d107e41e-3d8c-404c-bc19-e83509c0879a	94ab8191-d260-4a92-a49a-37a4cb42dab1	order_TA5k0TwGmZb5aB	pay_TA5k7AjVLnRrUa	129900	SUCCESS	2026-07-06 04:52:35.128
e07126b7-32a0-457c-870b-712c01ddea7c	d107e41e-3d8c-404c-bc19-e83509c0879a	94ab8191-d260-4a92-a49a-37a4cb42dab1	order_TA5lBuOPVjNC0s	pay_TA5lGfYHjKrEqe	129900	SUCCESS	2026-07-06 04:53:38.74
cc03234f-8508-483c-9a96-6631c0445ecd	d107e41e-3d8c-404c-bc19-e83509c0879a	94ab8191-d260-4a92-a49a-37a4cb42dab1	order_TA5r3oDMCDQOYD	pay_TA5r9VFlYzGvKS	129900	SUCCESS	2026-07-06 05:00:39.901
77e25fee-494f-46cf-a979-ddd5f2efd2bb	d107e41e-3d8c-404c-bc19-e83509c0879a	94ab8191-d260-4a92-a49a-37a4cb42dab1	order_TA5tXbUQQJwJKI	pay_TA5tcewgYCxOdb	129900	SUCCESS	2026-07-06 05:01:34.088
ebe83f91-7a12-419d-820a-d1d782d3ff1e	d107e41e-3d8c-404c-bc19-e83509c0879a	43e25745-187c-4e30-a665-893bb1ef53f2	order_TA6Pj7jWWhiaY5	pay_TA6PsNDrqk3TiE	100000	SUCCESS	2026-07-06 05:32:22.036
\.


--
-- Data for Name: Service; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Service" (id, title, category, description, price, "createdAt", "updateAt", image) FROM stdin;
e47d5b1b-f6d2-4b9a-84d1-4056f742eff6	Birth Chart Reading	Kundli	A comprehensive analysis of your natal chart covering planetary positions, strengths, weaknesses, life purpose, career potential, relationship patterns, and major life cycles. Ideal for individuals seeking a deeper understanding of their life path.	999	2026-06-28 20:19:27.161	2026-06-28 20:19:27.161	https://images.unsplash.com/photo-1532968961962-8a0cb3a2d4f5
e478f9f7-9a34-418b-8cf8-b3a34b12b4d3	Career Consultation	Career	Get guidance on career growth, job opportunities, promotions, career transitions, entrepreneurship, and professional challenges based on planetary influences and current astrological periods.	799	2026-06-28 20:20:07.495	2026-06-28 20:20:07.495	https://images.unsplash.com/photo-1521791136064-7986c2920216
b5786be4-5669-4d0f-932c-dcfdfc625c0b	Love & Relationship Consultation	Relationship	Understand relationship compatibility, emotional patterns, communication challenges, romantic prospects, and future relationship opportunities through astrological analysis.	899	2026-06-28 20:20:23.406	2026-06-28 20:20:23.406	https://images.unsplash.com/photo-1516589178581-6cd7833ae3b2
3a7a7916-4451-4801-9bde-546bea37ac75	Marriage Consultation	Marriage	Detailed consultation regarding marriage timing, compatibility, marital harmony, relationship obstacles, and remedies for delays or recurring challenges.	999	2026-06-28 20:25:58.799	2026-06-28 20:25:58.799	https://images.unsplash.com/photo-1511285560929-80b456fea0bc
7eded7ac-b43f-415f-8b5d-aeb8dc2828e2	Family Consultation	Family	Resolve family conflicts, improve relationships among family members, understand family karma, and create harmony within the household.	799	2026-06-28 20:25:58.799	2026-06-28 20:25:58.799	https://images.unsplash.com/photo-1511895426328-dc8714191300
cc44be88-36da-4840-9c6a-0bc9bfea71e6	Finance & Wealth Consultation	Finance	Insights into wealth creation, financial stability, investments, business opportunities, periods of prosperity, and strategies for long-term financial growth.	1099	2026-06-28 20:25:58.799	2026-06-28 20:25:58.799	https://images.unsplash.com/photo-1520607162513-77705c0f0d4a
7113c999-ea44-414e-af14-b7a4efb0bd97	Business Consultation	Business	Astrological guidance for entrepreneurs, startups, partnerships, expansion plans, investments, and strategic business decisions.	1199	2026-06-28 20:25:58.799	2026-06-28 20:25:58.799	https://images.unsplash.com/photo-1552664730-d307ca884978
d35f6541-c9b8-442b-bc82-22d06f8568e6	Education Consultation	Education	Academic guidance, exam success strategies, higher education planning, learning strengths, and educational career direction.	699	2026-06-28 20:25:58.799	2026-06-28 20:25:58.799	https://images.unsplash.com/photo-1522202176988-66273c2fd55f
8ba1bfd9-d22e-4540-8b64-ac0f9ff53eec	Foreign Travel & Settlement	Travel	Explore opportunities related to international travel, overseas studies, work visas, immigration, and foreign settlement prospects.	1199	2026-06-28 20:25:58.799	2026-06-28 20:25:58.799	https://images.unsplash.com/photo-1436491865332-7a61a109cc05
0a70612a-ef03-4e35-8b96-2db260f3be84	Property & Real Estate Consultation	Property	Guidance regarding property purchases, investments, construction projects, relocation decisions, and real estate opportunities.	999	2026-06-28 20:25:58.799	2026-06-28 20:25:58.799	https://images.unsplash.com/photo-1560518883-ce09059eeffa
f6ce44d6-0a63-445a-9978-b5a72a20cebc	Child & Parenting Consultation	Parenting	Understand your child's personality, educational potential, strengths, developmental patterns, and parenting approaches.	799	2026-06-28 20:25:58.799	2026-06-28 20:25:58.799	https://images.unsplash.com/photo-1503454537195-1dcabb73ffb9
bf9a8a42-3dfa-4e9c-bff8-15e8f069dd06	Health Consultation	Health	Receive astrological wellness insights, identify vulnerable health periods, and learn preventive lifestyle recommendations. Not a substitute for medical advice.	899	2026-06-28 20:25:58.799	2026-06-28 20:25:58.799	https://images.unsplash.com/photo-1576091160399-112ba8d25d1f
e421a2fd-5576-4a44-9b30-44b33487e451	Remedy Consultation	Remedies	Personalized remedies including mantras, gemstones, donations, rituals, spiritual practices, and planetary balancing techniques.	699	2026-06-28 20:25:58.799	2026-06-28 20:25:58.799	https://images.unsplash.com/photo-1518562180175-34a163b1a9a6
9899d6f4-eaa1-4f78-b202-ab6938fb0d66	Spiritual Guidance	Spiritual	Discover your spiritual path, life purpose, karmic lessons, meditation practices, and personal transformation opportunities.	799	2026-06-28 20:25:58.799	2026-06-28 20:25:58.799	https://images.unsplash.com/photo-1506126613408-eca07ce68773
c0dfe382-0952-44b3-a3b9-1737a124c5ea	Numerology Consultation	Numerology	Analyze life path numbers, destiny numbers, personal year cycles, name vibrations, and numerological influences on major decisions.	599	2026-06-28 20:25:58.799	2026-06-28 20:25:58.799	https://images.unsplash.com/photo-1515940175183-6798529cb860
25458d07-065a-4f1c-9be6-f834036e949b	Tarot Reading	Tarot	Gain clarity on relationships, career choices, personal growth, and upcoming opportunities through intuitive tarot card readings.	699	2026-06-28 20:25:58.799	2026-06-28 20:25:58.799	https://images.unsplash.com/photo-1604881991720-f91add269bed
b52f9726-b6ba-4bff-9b96-992ea725a09e	Horoscope Consultation	Horoscope	Personalized forecasts covering daily, monthly, and yearly astrological influences tailored to your birth chart.	599	2026-06-28 20:25:58.799	2026-06-28 20:25:58.799	https://images.unsplash.com/photo-1519682337058-a94d519337bc
0084c072-e76a-4091-945c-43910b9485e7	Muhurat Consultation	Muhurat	Selection of the most auspicious timing for marriage, business launches, travel, property purchases, and important life events.	899	2026-06-28 20:25:58.799	2026-06-28 20:25:58.799	https://images.unsplash.com/photo-1501139083538-0139583c060f
5cd9126f-229e-421d-bc46-7e62182dad8c	Vastu Consultation	Vastu	Analysis of home, office, or commercial spaces to improve energy flow, prosperity, harmony, productivity, and well-being.	1499	2026-06-28 20:25:58.799	2026-06-28 20:25:58.799	https://images.unsplash.com/photo-1484154218962-a197022b5858
94ab8191-d260-4a92-a49a-37a4cb42dab1	Dosha Analysis & Solutions	Dosha	Detailed examination of Manglik Dosha, Kaal Sarp Dosha, Pitra Dosha, and other astrological imbalances with personalized remedies.	129	2026-06-28 20:18:23.549	2026-07-06 05:29:00.824	https://images.unsplash.com/photo-1462331940025-496dfbfc7564
43e25745-187c-4e30-a665-893bb1ef53f2	Neew Service	Not known	this is test	1000	2026-07-06 05:30:48.365	2026-07-06 05:30:48.365	https://images.unsplash.com/photo-1782046820445-d2798c847f8f?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHw5fHx8ZW58MHx8fHx8
dd13ca09-0b48-4d64-a2d1-f33d8366e973	test -2 	not known	a	10	2026-07-06 05:35:58.444	2026-07-06 05:35:58.444	https://plus.unsplash.com/premium_photo-1688430696418-a3ccf3a4f7e2?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwxMXx8fGVufDB8fHx8fA%3D%3D
\.


--
-- Data for Name: Slot; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Slot" (id, start, "end", status, "reservedByUserId", "reservedUntill", "createdAt", "updatedAt", date) FROM stdin;
23a2020b-c967-4928-aa72-0cededdf3ecf	16:00	17:00	AVAILABLE	\N	\N	2026-07-01 13:11:47.449	2026-07-01 13:11:47.449	2026-07-30 18:30:00
5942db3c-89ea-4303-ab6d-11917fbebe88	19:00	20:00	AVAILABLE	\N	\N	2026-07-01 13:11:47.451	2026-07-01 13:11:47.451	2026-07-30 18:30:00
b0855636-4005-4dbc-b71e-7f52d76d179a	20:00	21:00	AVAILABLE	\N	\N	2026-07-01 13:11:47.452	2026-07-01 13:11:47.452	2026-07-30 18:30:00
0f7eefda-8f43-4ea8-b285-33c8ec858e9a	14:00	15:00	RESERVED	\N	2026-07-01T13:27:10.736Z	2026-07-01 13:11:47.444	2026-07-01 13:12:10.754	2026-07-30 18:30:00
77b074f1-beaf-47af-85c9-523379336722	14:00	15:00	RESERVED	\N	2026-07-02T14:32:04.645Z	2026-06-29 21:57:18.854	2026-07-02 14:17:04.652	2026-07-10 18:30:00
95bdc572-5713-43ab-a096-c937b66bca05	14:00	15:00	AVAILABLE	\N	\N	2026-07-02 18:30:52.819	2026-07-02 18:30:52.819	2026-08-01 18:30:00
bd433602-cb4a-45ec-a64f-143a385da516	16:00	17:00	AVAILABLE	\N	\N	2026-07-02 18:30:52.821	2026-07-02 18:30:52.821	2026-08-01 18:30:00
7c86b89f-a6a5-453b-9906-a28d52282797	19:00	20:00	AVAILABLE	\N	\N	2026-07-02 18:30:52.822	2026-07-02 18:30:52.822	2026-08-01 18:30:00
3ec3b040-3441-4476-ab0f-530ad8e8262b	20:00	21:00	AVAILABLE	\N	\N	2026-07-02 18:30:52.823	2026-07-02 18:30:52.823	2026-08-01 18:30:00
faeb80c1-b866-432a-a5c4-7a34aefde3b6	14:00	15:00	AVAILABLE	\N	\N	2026-07-04 09:48:20.651	2026-07-04 09:48:20.651	2026-08-02 18:30:00
a9bed035-ce6a-42e6-98ab-2e9d76482cb8	16:00	17:00	AVAILABLE	\N	\N	2026-07-04 09:48:20.656	2026-07-04 09:48:20.656	2026-08-02 18:30:00
2b6daf0b-b040-42a8-83d3-d70359433391	19:00	20:00	AVAILABLE	\N	\N	2026-07-04 09:48:20.657	2026-07-04 09:48:20.657	2026-08-02 18:30:00
df6d7b4e-cd0a-47fa-8cca-01a38a2bbc29	20:00	21:00	AVAILABLE	\N	\N	2026-07-04 09:48:20.658	2026-07-04 09:48:20.658	2026-08-02 18:30:00
74dfc068-6b91-4919-9271-9fc881225af5	14:00	15:00	BOOKED	d107e41e-3d8c-404c-bc19-e83509c0879a	\N	2026-06-29 21:57:18.856	2026-07-06 04:46:15.598	2026-07-11 18:30:00
95470422-797c-47b4-a864-9eb94cfff848	16:00	17:00	BOOKED	\N	\N	2026-06-29 21:57:18.832	2026-06-29 21:57:18.832	2026-07-01 18:30:00
04b3f09c-db21-4039-b453-3a10d0d29435	20:00	21:00	RESERVED	\N	2026-06-30T16:21:02.596Z	2026-06-29 21:57:18.837	2026-06-30 16:06:02.612	2026-07-02 18:30:00
310db173-6795-4d53-a2e8-989b5db3b001	14:00	15:00	RESERVED	\N	2026-06-30T16:30:19.375Z	2026-06-29 21:57:18.835	2026-06-30 16:15:19.386	2026-07-02 18:30:00
05cd4560-7cb8-4092-8dd5-fdacc7a37cbe	16:00	17:00	RESERVED	\N	2026-06-30T16:31:23.970Z	2026-06-29 21:57:18.835	2026-06-30 16:16:23.974	2026-07-02 18:30:00
fbc29e92-6c30-4ba9-b9b8-a8e2af014061	20:00	21:00	RESERVED	\N	2026-06-30T16:32:08.901Z	2026-06-29 21:57:18.84	2026-06-30 16:17:08.906	2026-07-03 18:30:00
1d09bc49-b7ef-4cad-9dc2-bf688dd34c3a	19:00	20:00	RESERVED	\N	2026-06-30T16:32:46.925Z	2026-06-29 21:57:18.836	2026-06-30 16:17:46.929	2026-07-02 18:30:00
4ad1ee59-f034-4a07-b6c1-4175630e93b5	14:00	15:00	RESERVED	\N	2026-06-30T16:39:08.945Z	2026-06-29 21:57:18.838	2026-06-30 16:24:08.964	2026-07-03 18:30:00
5d4ffea1-61bd-403b-a940-d4ca407706b4	19:00	20:00	RESERVED	\N	2026-06-30T16:44:16.077Z	2026-06-29 21:57:18.84	2026-06-30 16:29:16.096	2026-07-03 18:30:00
546f64fa-a137-4fdc-b9aa-9ff7fc1aae62	20:00	21:00	RESERVED	\N	2026-06-30T16:47:43.060Z	2026-06-29 21:57:18.842	2026-06-30 16:32:43.078	2026-07-04 18:30:00
d9b15bf6-2e42-409f-8eba-b30c3c6c6ba2	14:00	15:00	BOOKED	\N	Not Reserved Now	2026-06-29 21:57:18.841	2026-06-30 17:04:10.641	2026-07-04 18:30:00
875a4eee-9fcf-45d0-848f-5547221aa462	16:00	17:00	BOOKED	\N	Not Reserved Now	2026-06-29 21:57:18.839	2026-06-30 17:05:46.034	2026-07-03 18:30:00
cc51e999-46d1-49ff-a735-b22a0f4a1b92	19:00	20:00	RESERVED	7907c9ac-242c-4391-818e-48ff977fae8f	2026-07-03T05:51:51.562Z	2026-06-29 21:57:18.851	2026-07-03 05:36:51.585	2026-07-08 18:30:00
0deae9a4-97a3-4977-b61d-f21c39357b5e	19:00	20:00	BOOKED	\N	Not Reserved Now	2026-06-29 21:57:18.842	2026-06-30 17:07:24.219	2026-07-04 18:30:00
604c0752-ce1c-42f0-ac43-db73802bc5d5	16:00	17:00	RESERVED	\N	2026-06-30T17:30:45.243Z	2026-06-29 21:57:18.841	2026-06-30 17:15:45.261	2026-07-04 18:30:00
2ef98a5e-4010-49ef-8241-31e34e2790c7	14:00	15:00	AVAILABLE	\N	\N	2026-07-05 09:40:35.41	2026-07-05 09:40:35.41	2026-08-03 18:30:00
61c927ba-70a5-47f7-a122-fb08e522577f	14:00	15:00	BOOKED	\N	\N	2026-06-29 21:57:18.843	2026-06-30 17:41:42.66	2026-07-05 18:30:00
5e0fccae-d05a-4b51-a7f8-7f3727089ec0	14:00	15:00	AVAILABLE	\N	\N	2026-07-02 05:55:03.432	2026-07-02 05:55:03.432	2026-07-31 18:30:00
40bc4175-cede-47a5-900c-682f413509e3	16:00	17:00	AVAILABLE	\N	\N	2026-07-02 05:55:03.436	2026-07-02 05:55:03.436	2026-07-31 18:30:00
6dd9b096-570a-44ef-b52c-3bf98309cc45	19:00	20:00	AVAILABLE	\N	\N	2026-07-02 05:55:03.437	2026-07-02 05:55:03.437	2026-07-31 18:30:00
50968cf6-c0d6-45df-8d4d-806c709daab6	20:00	21:00	AVAILABLE	\N	\N	2026-07-02 05:55:03.438	2026-07-02 05:55:03.438	2026-07-31 18:30:00
5c2000b2-fd92-43ff-a505-84b1b190cd8d	16:00	17:00	RESERVED	\N	2026-07-02T14:06:23.745Z	2026-06-29 21:57:18.843	2026-07-02 13:51:23.773	2026-07-05 18:30:00
982428ab-196a-4c12-a321-189d9cdee92b	20:00	21:00	RESERVED	\N	2026-07-02T14:11:55.730Z	2026-06-29 21:57:18.844	2026-07-02 13:56:55.737	2026-07-05 18:30:00
cef41393-1422-401d-ace0-e35567a0d2ed	19:00	20:00	RESERVED	\N	2026-07-02T14:21:00.250Z	2026-06-29 21:57:18.844	2026-07-02 14:06:00.257	2026-07-05 18:30:00
347b34da-5d31-4f40-bed0-ea0ff3f221a9	19:00	20:00	RESERVED	\N	2026-07-02T14:23:26.631Z	2026-06-29 21:57:18.846	2026-07-02 14:08:26.636	2026-07-06 18:30:00
d15bb7a5-8844-4a9c-896e-d205a1a0bb2d	16:00	17:00	RESERVED	\N	2026-07-02T14:38:15.788Z	2026-06-29 21:57:18.852	2026-07-02 14:23:15.794	2026-07-09 18:30:00
93379c22-c4ae-4d50-b33a-94b263a96156	20:00	21:00	RESERVED	\N	2026-07-02T14:40:35.060Z	2026-06-29 21:57:18.847	2026-07-02 14:25:35.067	2026-07-06 18:30:00
9df09277-cb0f-4554-8b86-5c796328b6ac	16:00	17:00	RESERVED	\N	2026-07-02T14:58:38.378Z	2026-06-29 21:57:18.846	2026-07-02 14:43:38.386	2026-07-06 18:30:00
184c2520-2859-4475-bcae-58a0b29e0864	16:00	17:00	AVAILABLE	\N	\N	2026-07-05 09:40:35.415	2026-07-05 09:40:35.415	2026-08-03 18:30:00
1097c6d1-2817-48f6-840a-827db0f51b1c	19:00	20:00	AVAILABLE	\N	\N	2026-07-05 09:40:35.417	2026-07-05 09:40:35.417	2026-08-03 18:30:00
3111fa43-54f1-4a50-afdf-d6695344be10	20:00	21:00	AVAILABLE	\N	\N	2026-07-05 09:40:35.418	2026-07-05 09:40:35.418	2026-08-03 18:30:00
e5fbbc29-4443-4b25-b480-0734574f70aa	08:53	15:00	BOOKED	\N	2026-07-02T18:33:22.895Z	2026-06-29 21:57:18.845	2026-07-06 08:53:34.393	2026-07-06 08:53:34.393
8fd8c046-87f0-4f54-addc-87bda7d1c27d	14:00	15:00	BOOKED	d107e41e-3d8c-404c-bc19-e83509c0879a	\N	2026-06-29 21:57:18.858	2026-07-06 05:01:34.094	2026-07-12 18:30:00
4c780182-4ab9-4178-ba3f-8e1d0e4d6f89	14:00	15:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.861	2026-06-29 21:57:18.861	2026-07-13 18:30:00
3db723b1-6101-402f-aa47-c9780f0b5e3a	16:00	17:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.861	2026-06-29 21:57:18.861	2026-07-13 18:30:00
c1ee90cd-c243-4777-a88c-52d64d7eaf38	19:00	20:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.862	2026-06-29 21:57:18.862	2026-07-13 18:30:00
2f2cc812-e10c-40ac-b277-677ad2ddb80a	20:00	21:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.862	2026-06-29 21:57:18.862	2026-07-13 18:30:00
b6383973-ee85-47cd-833d-f6c09769f75a	14:00	15:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.863	2026-06-29 21:57:18.863	2026-07-14 18:30:00
e9909bfc-122e-4d0e-8045-ed078f1128ce	16:00	17:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.863	2026-06-29 21:57:18.863	2026-07-14 18:30:00
c3b6bf5b-6bb7-48ef-89e9-5955afba3978	19:00	20:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.864	2026-06-29 21:57:18.864	2026-07-14 18:30:00
00fefe61-4db0-45db-b23d-eca458988a6c	20:00	21:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.864	2026-06-29 21:57:18.864	2026-07-14 18:30:00
3efb0cf1-5344-4ba8-a76c-9c138555f338	14:00	15:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.865	2026-06-29 21:57:18.865	2026-07-15 18:30:00
66f839b6-0dec-4d68-83dd-5ee03fcd5c95	16:00	17:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.866	2026-06-29 21:57:18.866	2026-07-15 18:30:00
1718edd1-34c8-4240-b131-938decdd6754	19:00	20:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.866	2026-06-29 21:57:18.866	2026-07-15 18:30:00
e281b4c1-19bf-4e0e-ac58-e728288508f5	20:00	21:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.867	2026-06-29 21:57:18.867	2026-07-15 18:30:00
558d7c87-50ed-45f0-b071-26f413cd3f0c	14:00	15:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.867	2026-06-29 21:57:18.867	2026-07-16 18:30:00
942b5bbb-99c6-4975-a035-dbd4d5341833	16:00	17:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.868	2026-06-29 21:57:18.868	2026-07-16 18:30:00
1a09117c-69f7-4d2c-9ef7-edde1aea7f09	19:00	20:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.868	2026-06-29 21:57:18.868	2026-07-16 18:30:00
ded1ffcd-23f3-469b-abdd-f5cb1b20ae23	20:00	21:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.869	2026-06-29 21:57:18.869	2026-07-16 18:30:00
8ef6569f-1e14-4b2b-9ae3-12ed861fdde5	14:00	15:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.869	2026-06-29 21:57:18.869	2026-07-17 18:30:00
c8ae6ec9-ee65-4da4-8cb0-caf95d6a713f	16:00	17:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.87	2026-06-29 21:57:18.87	2026-07-17 18:30:00
08793f8d-cd84-4b9e-803d-3f2b7fe9d5da	19:00	20:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.87	2026-06-29 21:57:18.87	2026-07-17 18:30:00
f37c1e32-49bd-4638-a3cb-2c00a9a8d22a	20:00	21:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.871	2026-06-29 21:57:18.871	2026-07-17 18:30:00
59d62f34-dea0-405d-b2fb-8598eb565755	14:00	15:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.872	2026-06-29 21:57:18.872	2026-07-18 18:30:00
b569704c-6c81-4817-858d-d889fc9f53cc	16:00	17:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.872	2026-06-29 21:57:18.872	2026-07-18 18:30:00
ed065e28-d555-4824-8c0f-ea3a9958ce76	19:00	20:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.873	2026-06-29 21:57:18.873	2026-07-18 18:30:00
9d4e5a39-7be1-4bb5-af90-2230c186d5d8	20:00	21:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.873	2026-06-29 21:57:18.873	2026-07-18 18:30:00
82b857c5-9b07-4a99-97c4-243091b82293	14:00	15:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.874	2026-06-29 21:57:18.874	2026-07-19 18:30:00
43924421-07fb-4b8c-b935-44d992d2d0eb	16:00	17:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.874	2026-06-29 21:57:18.874	2026-07-19 18:30:00
1f2130c4-e9d7-4bfe-ab69-fa76b42ecf4c	19:00	20:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.875	2026-06-29 21:57:18.875	2026-07-19 18:30:00
cb0e4863-7bc9-48a4-b207-d13353139713	20:00	21:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.875	2026-06-29 21:57:18.875	2026-07-19 18:30:00
481053d6-7a28-4775-a14c-184b22c126b1	14:00	15:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.875	2026-06-29 21:57:18.875	2026-07-20 18:30:00
572c1399-33e5-4097-ae10-b8989b25af7f	16:00	17:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.876	2026-06-29 21:57:18.876	2026-07-20 18:30:00
12fff158-0650-421b-9b80-ade4a7dc1c20	19:00	20:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.876	2026-06-29 21:57:18.876	2026-07-20 18:30:00
06026b35-1029-47fe-8d88-ffe665c1d42d	20:00	21:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.876	2026-06-29 21:57:18.876	2026-07-20 18:30:00
3ed802ad-f3a0-4096-8a17-64a9926b38dc	14:00	15:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.877	2026-06-29 21:57:18.877	2026-07-21 18:30:00
fd2ac35c-9534-4c7d-84f1-cbe4b4972fd3	16:00	17:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.877	2026-06-29 21:57:18.877	2026-07-21 18:30:00
d1bb5daf-1b2c-4fff-b0c5-eb6c24985f0a	19:00	20:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.877	2026-06-29 21:57:18.877	2026-07-21 18:30:00
d5798714-585e-4f1e-a8b9-b306974eda11	20:00	21:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.878	2026-06-29 21:57:18.878	2026-07-21 18:30:00
b7fca92c-7d4b-41c0-915e-024556dad80d	14:00	15:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.878	2026-06-29 21:57:18.878	2026-07-22 18:30:00
e81f1088-fb85-437a-a538-5492a7be042c	16:00	17:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.879	2026-06-29 21:57:18.879	2026-07-22 18:30:00
9232ed76-dbcd-44cf-9b2b-6b82991d1596	19:00	20:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.879	2026-06-29 21:57:18.879	2026-07-22 18:30:00
45184fbb-0b3f-4146-af1e-a7a7e3984fdd	20:00	21:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.88	2026-06-29 21:57:18.88	2026-07-22 18:30:00
639b38cd-6595-456a-905c-97a7a0e6e6ab	14:00	15:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.88	2026-06-29 21:57:18.88	2026-07-23 18:30:00
4eb9c9b8-81e2-4490-96f1-64b16e533677	16:00	17:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.881	2026-06-29 21:57:18.881	2026-07-23 18:30:00
b0d54f05-fa37-4d5f-9570-fda761f9d7b4	19:00	20:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.881	2026-06-29 21:57:18.881	2026-07-23 18:30:00
089e9e18-9a02-4bfe-b18e-5d2a49fd42ed	20:00	21:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.882	2026-06-29 21:57:18.882	2026-07-23 18:30:00
9d23373b-d895-4c06-9061-cab2439f8316	14:00	15:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.883	2026-06-29 21:57:18.883	2026-07-24 18:30:00
6733fc58-1eb9-485a-82c1-fb76ccbc62db	16:00	17:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.883	2026-06-29 21:57:18.883	2026-07-24 18:30:00
ea19de3c-d82c-4eed-a482-04a915046600	16:00	17:00	RESERVED	\N	2026-07-02T14:34:14.600Z	2026-06-29 21:57:18.848	2026-07-02 14:19:14.606	2026-07-07 18:30:00
5431b52f-661d-48fa-aa31-7ba2a85fc241	14:00	15:00	RESERVED	\N	2026-07-02T14:39:12.249Z	2026-06-29 21:57:18.852	2026-07-02 14:24:12.255	2026-07-09 18:30:00
206246c6-a2b9-4e3a-9186-02c577ef6944	20:00	21:00	RESERVED	\N	2026-07-02T14:59:44.024Z	2026-06-29 21:57:18.853	2026-07-02 14:44:44.031	2026-07-09 18:30:00
a523d0a3-026d-4ff6-9899-e813a96764a4	14:00	15:00	RESERVED	\N	2026-07-02T18:36:03.010Z	2026-06-29 21:57:18.847	2026-07-02 18:21:03.018	2026-07-07 18:30:00
0c02aa09-e7ff-47a9-be7f-ea6ff0e75150	14:00	15:00	RESERVED	\N	2026-07-02T18:45:56.037Z	2026-06-29 21:57:18.85	2026-07-02 18:30:56.052	2026-07-08 18:30:00
887d60dc-21b2-43ca-84ef-397624d641d1	20:00	21:00	BOOKED	\N	\N	2026-06-29 21:57:18.85	2026-07-02 18:25:10.477	2026-07-07 18:30:00
d3dba7d1-771f-4f73-80bc-acbe3347cccb	00:00	23:59	BOOKED	7907c9ac-242c-4391-818e-48ff977fae8f	\N	2026-06-29 21:57:18.851	2026-07-03 03:53:08.141	2026-07-03 11:16:38.845
b580650e-c1ec-4a3d-a57f-14d495376f82	16:00	17:00	BOOKED	\N	6f0ec6b9-54c7-499f-a9b0-497ba3d8320c	2026-06-29 21:57:18.85	2026-07-02 18:49:32.088	2026-07-08 18:30:00
d45a0ba5-1f1a-4436-b4a6-0566af3f8340	19:00	20:00	RESERVED	d107e41e-3d8c-404c-bc19-e83509c0879a	2026-07-06T05:53:41.720Z	2026-06-29 21:57:18.859	2026-07-06 05:38:41.73	2026-07-12 18:30:00
8feb309e-9c9e-462a-8b36-5f2fa95cd15f	19:00	20:00	BOOKED	7907c9ac-242c-4391-818e-48ff977fae8f	\N	2026-06-29 21:57:18.853	2026-07-03 05:39:21.042	2026-07-09 18:30:00
82120039-4ca5-47a6-9536-fe27952a1214	20:00	21:00	BOOKED	7907c9ac-242c-4391-818e-48ff977fae8f	\N	2026-06-29 21:57:18.855	2026-07-04 09:48:47.178	2026-07-10 18:30:00
44199dd5-30bd-4330-973b-244a61df27a8	19:00	20:00	BOOKED	d107e41e-3d8c-404c-bc19-e83509c0879a	\N	2026-06-29 21:57:18.855	2026-07-05 09:41:04.773	2026-07-10 18:30:00
62667f08-8d46-4f6c-bbf3-0286e5e17738	16:00	17:00	BOOKED	d107e41e-3d8c-404c-bc19-e83509c0879a	\N	2026-06-29 21:57:18.857	2026-07-06 04:52:35.134	2026-07-11 18:30:00
e17b8db9-806b-4ac6-8861-a49b5de45805	19:00	20:00	BOOKED	d107e41e-3d8c-404c-bc19-e83509c0879a	\N	2026-06-29 21:57:18.858	2026-07-06 04:53:38.747	2026-07-11 18:30:00
69ee4bc5-4fb6-4925-9194-c3b6e5c1d79e	20:00	21:00	BOOKED	d107e41e-3d8c-404c-bc19-e83509c0879a	\N	2026-06-29 21:57:18.858	2026-07-06 05:00:39.905	2026-07-11 18:30:00
7605ebd1-8789-4d83-b18a-68b5abfbb52a	16:00	17:00	BOOKED	d107e41e-3d8c-404c-bc19-e83509c0879a	\N	2026-06-29 21:57:18.859	2026-07-06 05:32:22.045	2026-07-12 18:30:00
b65019c1-eb8b-4c8e-82e1-e1769c6dbe69	20:00	21:00	RESERVED	7907c9ac-242c-4391-818e-48ff977fae8f	2026-07-06T06:04:57.351Z	2026-06-29 21:57:18.86	2026-07-06 05:49:57.373	2026-07-12 18:30:00
fc88b377-b1fd-4fbf-b6b8-18dc8d031e15	19:00	20:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.884	2026-06-29 21:57:18.884	2026-07-24 18:30:00
4e00f644-fa72-4914-86db-77d94ce349d0	20:00	21:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.884	2026-06-29 21:57:18.884	2026-07-24 18:30:00
ee6fbd03-9b69-497c-abf6-934c512edbc1	14:00	15:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.884	2026-06-29 21:57:18.884	2026-07-25 18:30:00
65cb61fd-eba6-4f03-9de4-9ebb0a4299b3	16:00	17:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.885	2026-06-29 21:57:18.885	2026-07-25 18:30:00
c4f88c75-1d0c-400e-bade-3fde76ca80b1	19:00	20:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.885	2026-06-29 21:57:18.885	2026-07-25 18:30:00
1b9069de-6285-46c9-9373-9d3f82065e57	20:00	21:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.886	2026-06-29 21:57:18.886	2026-07-25 18:30:00
4f7e09e4-0f7f-4451-9792-d7bf76f8e6e3	14:00	15:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.886	2026-06-29 21:57:18.886	2026-07-26 18:30:00
19ff9171-d5a6-469d-980a-0f074bca33de	16:00	17:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.887	2026-06-29 21:57:18.887	2026-07-26 18:30:00
45a149cb-c475-4d95-a1be-5ad2683eb8fd	19:00	20:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.887	2026-06-29 21:57:18.887	2026-07-26 18:30:00
4f16c483-3242-436c-9702-39a22e106199	20:00	21:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.888	2026-06-29 21:57:18.888	2026-07-26 18:30:00
0eac91d3-b60c-4a8d-b064-baf5a088477f	14:00	15:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.888	2026-06-29 21:57:18.888	2026-07-27 18:30:00
46b89744-2f16-4af4-87e3-2b04a599978c	16:00	17:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.889	2026-06-29 21:57:18.889	2026-07-27 18:30:00
e34fff06-f1bb-49a6-94b4-277dd379dfbb	19:00	20:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.889	2026-06-29 21:57:18.889	2026-07-27 18:30:00
37866309-99bb-4289-bab9-7ead110e06a7	20:00	21:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.89	2026-06-29 21:57:18.89	2026-07-27 18:30:00
8a350677-ee95-43ea-8fd9-41d779d6d437	14:00	15:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.89	2026-06-29 21:57:18.89	2026-07-28 18:30:00
3994fef1-6f7a-4343-afde-8b196542a4f1	16:00	17:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.89	2026-06-29 21:57:18.89	2026-07-28 18:30:00
7a986c6b-e23e-4f0b-9c4f-10ef710a6a9e	19:00	20:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.891	2026-06-29 21:57:18.891	2026-07-28 18:30:00
b2cdef3d-2e75-452c-b4e1-4947577e265c	20:00	21:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.891	2026-06-29 21:57:18.891	2026-07-28 18:30:00
aacfaddd-8e7c-4c71-b30b-3b2f9ecb0406	14:00	15:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.891	2026-06-29 21:57:18.891	2026-07-29 18:30:00
91621858-f7c0-4858-9f87-94b19154bf63	16:00	17:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.892	2026-06-29 21:57:18.892	2026-07-29 18:30:00
3a1687ce-833f-4497-bea5-4a218a07eee5	19:00	20:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.892	2026-06-29 21:57:18.892	2026-07-29 18:30:00
4e0e8427-f58f-47d8-8b1a-681d8710ef7b	20:00	21:00	AVAILABLE	\N	\N	2026-06-29 21:57:18.893	2026-06-29 21:57:18.893	2026-07-29 18:30:00
cb79527c-4af8-4734-aebd-e8b9f465cdfc	19:00	20:00	RESERVED	\N	2026-07-02T18:36:54.175Z	2026-06-29 21:57:18.849	2026-07-02 18:21:54.181	2026-07-07 18:30:00
081401eb-952b-41a8-aabd-fc24b097412b	23:35	23:59	BOOKED	7907c9ac-242c-4391-818e-48ff977fae8f	\N	2026-06-29 21:57:18.854	2026-07-03 15:03:36.82	2026-07-03 00:00:00
d7bd0bb8-75d8-4138-b7a1-449396b7035f	14:00	15:00	AVAILABLE	\N	\N	2026-07-06 03:17:51.43	2026-07-06 03:17:51.43	2026-08-04 18:30:00
3a20b700-53bd-4ceb-8523-22dd4545683f	16:00	17:00	AVAILABLE	\N	\N	2026-07-06 03:17:51.435	2026-07-06 03:17:51.435	2026-08-04 18:30:00
ed6f87c4-82b7-4923-8e5c-c516f8d6a520	19:00	20:00	AVAILABLE	\N	\N	2026-07-06 03:17:51.437	2026-07-06 03:17:51.437	2026-08-04 18:30:00
868dce62-c1df-4e67-9281-9c834ad7e89b	20:00	21:00	AVAILABLE	\N	\N	2026-07-06 03:17:51.438	2026-07-06 03:17:51.438	2026-08-04 18:30:00
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" (id, "auth0Id", email, name, phone, "profileImage", "dateOfBirth", "birthTime", "birthPlace", gender, "isPremium", "createdAt", "updatedAt") FROM stdin;
629a4b21-8653-4f29-8ba7-d873aec148f4	auth0|687ab3c91234xyz	utkarsh.prakash@gmail.com	Utkarsh Prakash	+919876543210	https://res.cloudinary.com/astra/profile/utkarsh.jpg	2004-08-05 00:00:00	10:15 AM	Lucknow, Uttar Pradesh, India	Male	f	2026-06-28 19:41:03.875	2026-06-28 19:41:03.875
864b5fc8-8caa-49dc-a3bd-1ee360f5ddd6	auth0|987654321xyz	rahul.verma@gmail.com	Rahul Verma	+919812345678	https://res.cloudinary.com/astra/profile/rahul.jpg	1995-03-21 00:00:00	08:30 PM	Delhi, India	Male	f	2026-06-28 19:44:58.34	2026-06-28 19:44:58.34
d107e41e-3d8c-404c-bc19-e83509c0879a	apple|001603.221c7ea3eaef4362bba914991319ba3c.1713	iutkarsh0805@icloud.com	iutkarsh0805@icloud.com	\N	https://s.gravatar.com/avatar/c59f7ee47fcf6e87dd7df879de24a70c?s=480&r=pg&d=https%3A%2F%2Fcdn.auth0.com%2Favatars%2Fiu.png	\N	\N	\N	\N	f	2026-07-02 04:41:11.777	2026-07-02 04:41:11.777
7907c9ac-242c-4391-818e-48ff977fae8f	google-oauth2|114822873086670517481	utkarshprakash081105@gmail.com	Utkarsh Prakash	\N	https://lh3.googleusercontent.com/a/ACg8ocK6B5nNC2U9N-YXC0cqgJZiItf2HRZ31lVnSORHQ3YNXf7D0w=s96-c	\N	\N	\N	\N	f	2026-07-02 18:42:57.412	2026-07-02 18:42:57.412
6f0ec6b9-54c7-499f-a9b0-497ba3d8320c	google-oauth2|110536817626099653299	utkarshprakash0805@gmail.com	Utkarsh Prakash	\N	https://lh3.googleusercontent.com/a-/ALV-UjXeD9JYLIuQN3r6xFfBNg3hsZKoFytKi3gzdqKBnDrj0TutovHo-2nFgI1rM2hC56DLaHUOKV8D8hxTDEa3GbBW2nVjELxBt7G77vnGwu2zEZl1QpjoegRutiPKQz2vw05kDokGs9GvIuEEL2vrT2XIAO1ssc76OHHtn2B9UMglMtKxzfOxpDWw-59S_C4XAjQOWGzYD4a7EndBT85qEmy7zcvG-D8z-4vgPlTJv_vCJ37DFJmG982F5x2ceLZLOoIxX2-S7spchEsE_igkINuqWFac5sCNWfuroviuUgkrha6j_mf_Uy58_qPVwV5GxhQKUlFVn8RwoP0ks50-xnFj9Ev1jXOZLWv2JdwbCybL2l0JiNf5KFzW-ATjt3Pdio2-dUynF04q328zfqxtBh_dQtPgV2wkbCEv2rq6wnGFA9NekEA8F4WEjacsndDaqg8ZHef63P7on5mkPFuQBu8w9C9pGEvxkLRFyesGL-Qi6PMSeksk3QHEvRlZM2KA5v0prfMJDLB_keU7oqN2nsJF3KP1SfHDK-lmlhQGRhJdNtedOo3RERvaJRwZpuQEbs5pPtyuh-3CSU7PRlG0eJp4oC7Ne4m1lHbKfTzl5iFN7eXBTF-nNlwh71qXkgTrO5JDW7bVdDfcHeHEDjXLXiqJFDD10Lw3IKhDcTavWAX4P2q1S0MXPJNZQoeYEN-Tp-HliaF2IZD57QFaVTYJTFefq-CF3_dZjNNe3asR5zkl1kTyxAR3Tgl7p7evjM7ZklHshvwMoy5wpAaVxEXeZSTqimmU5eArUNwhsOQZ90DtNcZPAdE537tv3_MXKUXO5-rV6ancN1sldAfzXWAkwwtxu378E4cEdfSS1v6SdrWQr-8J7bZ2_xEbYVCB6tuo4XwBGT_st98iWX0JoOkz1CIOCiE6v_5Q5c8cm-2IgDJQREkV_CVLBTvxjIoPwXJNkDQcrNQcIuc0VXeUYqIMBF1IqU5QT9cED6AW-Cw2gveh2YNlyxmKOOi_PfUDqtFkKlvpsk55IHF57Z08dRE3ZSQpFtfvyPxxv792mhUcluno-sdZ-onBxg=s96-c	\N	\N	\N	\N	f	2026-07-02 18:46:49.864	2026-07-02 18:46:49.864
d479915d-a690-48e2-8e7b-da724f54d30c	auth0|6a48dbd22ddca52367c3f2e8	a@b.com	a@b.com	\N	https://s.gravatar.com/avatar/357a20e8c56e69d6f9734d23ef9517e8?s=480&r=pg&d=https%3A%2F%2Fcdn.auth0.com%2Favatars%2Fa.png	\N	\N	\N	\N	f	2026-07-04 10:09:24.076	2026-07-04 10:09:24.076
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
29a98e91-0982-4d91-ad2a-d24ba18fb27a	7a46f7237c45249a48a41697405ccabd744a74693b9b9377252874fd689081d9	2026-06-29 00:58:13.428995+05:30	20260628192813_init	\N	\N	2026-06-29 00:58:13.423969+05:30	1
f90aaceb-6431-4b98-aaaa-371305a6fc27	4eed67e6a48b28943000d3c7b55071ca77eaf9f5fbd33585bd672960e3a4db19	2026-07-05 20:35:54.61045+05:30	20260705150554_astrologer_table_generated	\N	\N	2026-07-05 20:35:54.603388+05:30	1
87579be9-8e14-43c6-ad1c-f641fbd893f9	3cb795f8ecaa33bcfccacf399a231be020ab7899b6c2b9630beda5e095048c23	2026-06-29 01:35:45.235952+05:30	20260628200545_add_services	\N	\N	2026-06-29 01:35:45.231527+05:30	1
cc87e525-b47e-43a7-947a-a39cb1737f43	f314ed53a5c52d8720e99109f543fd88f1abe8273684d7e4b980f5589d6b907c	2026-06-29 01:41:15.078337+05:30	20260628201115_add_image	\N	\N	2026-06-29 01:41:15.075711+05:30	1
928e7fd3-87c5-4d0d-8757-645e64dec36c	98822345560c00e42e5c3f24a4e00dfcedf163d663aa6662f528befa8b2c1bba	2026-06-29 10:44:19.188157+05:30	20260629051419_add_payment_model	\N	\N	2026-06-29 10:44:19.176462+05:30	1
286ed2ce-baac-4d06-9b23-c590f8eeb185	a78fe5ce26351d7c9db155807894f175325bda0059b6bb2898afc3623b11c651	2026-07-05 20:43:05.642188+05:30	20260705151305_asro_update	\N	\N	2026-07-05 20:43:05.633972+05:30	1
9d732c44-fb98-491e-9e68-0d97d1c107c5	a61da45203857e157d42cb16de1267b2e5a5c742330d6a685a962704e9e0239a	2026-06-30 01:14:31.343496+05:30	20260629194431_add_slot_and_booking	\N	\N	2026-06-30 01:14:31.331929+05:30	1
d8c9054d-fbcd-4b3a-b3e9-21e22828bae0	e91cebdd6f75a0b1dd85125a02704f437e8542bd78c612cf5034d619541b29d0	2026-06-30 01:26:11.043443+05:30	20260629195611_bookingstatus_updated	\N	\N	2026-06-30 01:26:11.041543+05:30	1
a87f83c4-ce8f-49b5-a6a7-65892aa3fc49	435cf329112758b8cb8b4a2e3ef0adc0d096be47217ded6aa8afe37dccaff394	2026-06-30 01:49:55.030672+05:30	20260629201955_slot_date_update	\N	\N	2026-06-30 01:49:55.028256+05:30	1
357fc6da-8d18-4719-b262-159783c4d2fd	c8b9bb33f98e8f58f210aee412b04b58ba44071e45f171f7eb4ca94a678611a2	2026-06-30 02:42:14.763229+05:30	20260629211214_slot_reserved_not_required	\N	\N	2026-06-30 02:42:14.761301+05:30	1
e13eab5f-05bc-4059-8152-772541641653	ad2e1072d872503b6d6422ae9e688456bba7eb051ff8666352b83452636c96ac	2026-06-30 20:47:03.384943+05:30	20260630151703_changed_schema_of_payment	\N	\N	2026-06-30 20:47:03.38091+05:30	1
a53011d5-6a98-4d64-9935-3ea111ee5b95	11c3e71c9ba661f90a81883da579f440dbbed7bfdf9ec79cc950c986a1e27f4c	2026-06-30 20:47:54.21382+05:30	20260630151754_changed_schema_of_payment	\N	\N	2026-06-30 20:47:54.210287+05:30	1
62a82eac-b8ff-47f2-9f43-771cf2aee1f5	5ea24212ac063785c4af63a6934d9e8ae86b9ced1c20e527055873c4a2ce4bb1	2026-07-01 08:27:49.294663+05:30	20260701025749_payement_migration	\N	\N	2026-07-01 08:27:49.287557+05:30	1
8602cd6a-216d-436a-b71b-05803ac0c149	e1845be7e0bfe6e23df3fa58cd4dbf749795dc83c65343a9a8a2f3c6643d7449	2026-07-01 08:28:39.950632+05:30	20260701025839_payement_update	\N	\N	2026-07-01 08:28:39.949541+05:30	1
077ca073-ae44-46fd-8826-06bd13f4f81b	5ecd853b6b8e5cf0ba4d69af213134b44275a95b970d58ae344581145666fe68	2026-07-02 23:47:11.739276+05:30	20260702181711_remove_unique	\N	\N	2026-07-02 23:47:11.735639+05:30	1
\.


--
-- Name: Astrologer Astrologer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Astrologer"
    ADD CONSTRAINT "Astrologer_pkey" PRIMARY KEY (id);


--
-- Name: Booking Booking_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Booking"
    ADD CONSTRAINT "Booking_pkey" PRIMARY KEY (id);


--
-- Name: Payment Payment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Payment"
    ADD CONSTRAINT "Payment_pkey" PRIMARY KEY (id);


--
-- Name: Service Service_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Service"
    ADD CONSTRAINT "Service_pkey" PRIMARY KEY (id);


--
-- Name: Slot Slot_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Slot"
    ADD CONSTRAINT "Slot_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: Astrologer_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Astrologer_email_key" ON public."Astrologer" USING btree (email);


--
-- Name: Astrologer_pass_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Astrologer_pass_key" ON public."Astrologer" USING btree (pass);


--
-- Name: Booking_meetingroomId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Booking_meetingroomId_key" ON public."Booking" USING btree ("meetingroomId");


--
-- Name: Booking_paymentId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Booking_paymentId_key" ON public."Booking" USING btree ("paymentId");


--
-- Name: Payment_razorpayOrderId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Payment_razorpayOrderId_key" ON public."Payment" USING btree ("razorpayOrderId");


--
-- Name: Payment_razorpayPaymentId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Payment_razorpayPaymentId_key" ON public."Payment" USING btree ("razorpayPaymentId");


--
-- Name: User_auth0Id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "User_auth0Id_key" ON public."User" USING btree ("auth0Id");


--
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- Name: Booking Booking_paymentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Booking"
    ADD CONSTRAINT "Booking_paymentId_fkey" FOREIGN KEY ("paymentId") REFERENCES public."Payment"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Booking Booking_serviceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Booking"
    ADD CONSTRAINT "Booking_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES public."Service"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Booking Booking_slotId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Booking"
    ADD CONSTRAINT "Booking_slotId_fkey" FOREIGN KEY ("slotId") REFERENCES public."Slot"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Booking Booking_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Booking"
    ADD CONSTRAINT "Booking_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Payment Payment_serviceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Payment"
    ADD CONSTRAINT "Payment_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES public."Service"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Payment Payment_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Payment"
    ADD CONSTRAINT "Payment_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

\unrestrict IJVmfJ7j41o4WS3uZYcgW1puqGs2Gx0gA3rPvfTytsOLvDhek8Mw0jEm7xWFz48

