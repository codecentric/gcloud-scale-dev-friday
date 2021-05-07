// Imports the Google Cloud client library
const { Bigtable } = require("@google-cloud/bigtable");

// Instantiates a client
const bigtable = new Bigtable();

const getRowGreeting = (row) => {
  return row.data["cf1"]["services"][0].value;
};

exports.readRows = async (req, res) => {
  // Gets a reference to a Cloud Bigtable instance and database
  const instance = bigtable.instance("scale-bigtable");
  const table = instance.table("scale-traffic");
  const [tableExists] = await table.exists();
  if (!tableExists) {
    res.send(`Error: Table not availabe Bigtable: ${err}`);
    res.status(500).end();
  } else {
    // Execute the query
    const filter = [
      {
        column: {
          cellLimit: 1,
        },
      },
    ];

    // read a single row
    console.log("Reading a single row by row key");
    const [singleRow] = await table.row("greeting").get({ filter });
    console.log(`\tRead: ${getRowGreeting(singleRow)}`);

    // read all rows from table

    const [allRows] = await table.getRows({ filter });
    for (const row of allRows) {
      console.log(`\tRead: ${getRowGreeting(row)}`);
    }

    // read from a stream
    try {
      const rows = [];
      await table
        .createReadStream({})
        .on("error", (err) => {
          res.send(`Error querying Bigtable: ${err}`);
          res.status(500).end();
        })
        .on("data", (row) => {
          rows.push(
            `rowkey: ${row.id}, ` +
              `os_build: ${row.data["stats_summary"]["os_build"][0].value}\n`
          );
        })
        .on("end", () => {
          rows.forEach((r) => res.write(r));
          res.status(200).end();
        });
    } catch (err) {
      res.send(`Error querying Bigtable: ${err}`);
      res.status(500).end();
    }
  }
};
