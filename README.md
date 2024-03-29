# The Mega-Big endpoint file

The goal of this project is to provide a single file that mashes together several datasets based on FinnGen endpoints.


**Requirements**

1. [Clickhouse](https://clickhouse.com/docs/en/install)
2. The datasets


**Usage**

1. Copy `config.json.template` to `config.json`
2. Edit `config.json` with the correct path for each dataset
3. Run like this:
   ```bash
   clickhouse local --join_use_nulls true --format_csv_null_representation ␀ --queries-file src/001.create_tables.sql src/002.insert_from_files.sql src/003.output.sql
   ```

 This will make the output file `mega-big-endpoint-file.csv.zst`.


**Debugging**

You can add `--echo` when you run the clickhouse command. This can help in debugging, it will print the SQL queries as it runs:

```bash
clickhouse local --echo --join_use_nulls true --format_csv_null_representation ␀ --queries-file src/001.create_tables.sql src/002.insert_from_files.sql src/003.output.sql
```
