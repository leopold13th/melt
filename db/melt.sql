-- Table: public.sectors
DROP TABLE IF EXISTS public.sectors CASCADE;

CREATE TABLE public.sectors
(
    id SERIAL,
    sub NUMERIC,
    name TEXT,
    CONSTRAINT sectors_pkey PRIMARY KEY (id)
)
TABLESPACE pg_default;

ALTER TABLE public.sectors OWNER to melt;

INSERT INTO public.sectors VALUES (DEFAULT, 0, 'SERVICES');
INSERT INTO public.sectors VALUES (DEFAULT, 1, 'ELECTRONIC GAMING & MULTIMEDIA');


-- Table: public.tickers
DROP TABLE IF EXISTS public.tickers CASCADE;

CREATE TABLE public.tickers
(
    id BIGSERIAL,
    ticker VARCHAR(32) COLLATE pg_catalog."default" NOT NULL,
    name VARCHAR(128) COLLATE pg_catalog."default" NOT NULL,
    div_status NUMERIC, -- 1-aristocrat, 2-king, 0-nothing
    sector VARCHAR(128), -- Sector промышленности в которой работает компания
    industry VARCHAR(128), -- отрасль промышленности в которой работает компания
    CONSTRAINT tickers_pkey PRIMARY KEY (id)
)
TABLESPACE pg_default;

ALTER TABLE public.tickers OWNER to melt;
COMMENT ON COLUMN public.tickers.div_status IS '0-none, 1-aristocrat, 2-king';
COMMENT ON COLUMN public.tickers.sector IS 'Sector промышленности в которой работает компания';
COMMENT ON COLUMN public.tickers.industry IS 'Отрасль промышленности в которой работает компания';

INSERT INTO public.tickers VALUES (DEFAULT, 'T', 'AT&T', 0, 'Telecom', '');
INSERT INTO public.tickers VALUES (DEFAULT, 'AAPL', 'Apple', 0, 'IT', '');
INSERT INTO public.tickers VALUES (DEFAULT, 'MSFT', 'Microsoft', 0, 'IT', '');
INSERT INTO public.tickers VALUES (DEFAULT, 'ATVI', 'Activision Blizzard, Inc.', 0, 'SERVICES', 'ELECTRONIC GAMING & MULTIMEDIA');
INSERT INTO public.tickers VALUES (DEFAULT, 'LITE', 'Lumentum Holdings Inc.', 0, 'TECHNOLOGY', 'COMMUNICATION EQUIPMENT');
INSERT INTO public.tickers VALUES (DEFAULT, 'PEP', 'PepsiCo, Inc.', 1, 'CONSUMER GOODS', 'BEVERAGES');
INSERT INTO public.tickers VALUES (DEFAULT, 'PG', 'The Procter & Gamble Company', 1, 'CONSUMER GOODS', 'HOUSEHOLD & PERSONAL PRODUCTS');
INSERT INTO public.tickers VALUES (DEFAULT, 'AMGN', 'Amgen Inc.', 0, 'HEALTHCARE', 'DRUG MANUFACTURERS');
INSERT INTO public.tickers VALUES (DEFAULT, 'ABBV', 'AbbVie Inc.', 1, 'HEALTHCARE', 'DRUG MANUFACTURERS');
INSERT INTO public.tickers VALUES (DEFAULT, 'MRK', 'Merck & Co., Inc.', 0, 'HEALTHCARE', 'DRUG MANUFACTURERS');


-- Table: public.actives
DROP TABLE IF EXISTS public.actives CASCADE;

CREATE TABLE public.actives
(
    id BIGSERIAL,
    ticker NUMERIC,
    qty NUMERIC, -- quantity
    price money,
    valuta TEXT,
    buy_date TIMESTAMP,
    broker NUMERIC,
    subaccount VARCHAR(128),
    CONSTRAINT actives_pkey PRIMARY KEY (id)
)
TABLESPACE pg_default;

ALTER TABLE public.actives OWNER to postgres;
COMMENT ON COLUMN public.actives.qty IS 'Количество активов';

INSERT INTO public.actives VALUES (DEFAULT, 1, 12, 99.99, 'USD', '2020-05-03 10:10:00-07', 1, '');
INSERT INTO public.actives VALUES (DEFAULT, 2, 4, 55.01, 'USD', '2020-06-22 19:10:25-07', 1, 'ИИС');


-- View: public.v$actives
CREATE OR REPLACE VIEW public.v$actives AS
    SELECT a.id, t.ticker, a.qty, a.price, a.valuta, a.buy_date
      FROM public.actives a, public.tickers t
     WHERE a.ticker = t.id;
