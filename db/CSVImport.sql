\COPY Products FROM '../CSVs/product.csv' WITH DELIMITER ',' CSV HEADER;

\COPY Styles FROM '../CSVs/styles.csv' WITH DELIMITER ',' CSV HEADER;

\COPY Features FROM '../CSVs/features.csv' WITH DELIMITER ',' CSV HEADER;

\COPY Photos FROM '../CSVs/photosfixed.csv' WITH DELIMITER ',' CSV HEADER;

\COPY Related FROM '../CSVs/related.csv' WITH DELIMITER ',' CSV HEADER;

\COPY Skus FROM '../CSVs/skus.csv' WITH DELIMITER ',' CSV HEADER;
