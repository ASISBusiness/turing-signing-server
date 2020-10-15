select * from contracts

delete from contracts

drop table contracts

CREATE TABLE contracts(
	contract VARCHAR(64) PRIMARY KEY UNIQUE NOT NULL,
	signer VARCHAR(56) UNIQUE NOT NULL,
	pendingTxns VARCHAR(96)[] DEFAULT NULL
)

ALTER TABLE contracts
ADD COLUMN pendingTxns VARCHAR(75)[] DEFAULT NULL

INSERT INTO contracts (contract, signer)
select 'GCNANNNLGDICM5NJOT7QD7MLW34M4WLJPTNOAXWEAR4CE4LO23FZ5WDR', 'SDRJWX2SNJTMFFGGGO4DQXL7X5SHVENZLYX6K7LCZQSIJ6XSEMTCXLHY'

update contracts set
	pendingtxns = NULL
WHERE contract = 'GCNANNNLGDICM5NJOT7QD7MLW34M4WLJPTNOAXWEAR4CE4LO23FZ5WDR'

update contracts set
	pendingtxns = (select array_agg(distinct e) from unnest(pendingtxns || '{${transaction.hash().toString('hex')}}') e)
where not pendingtxns @> '{${transaction.hash().toString('hex')}}'