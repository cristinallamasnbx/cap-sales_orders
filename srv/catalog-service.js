const cds = require("@sap/cds");
const Header = cds.entities("com.logali.Header");

module.exports = function (srv) {
    srv.after("READ", "Header", async (req) => {
        console.log('hello there');
    });

    /* Create */
    srv.on("CREATE", "Header", async (req) => {
        let returnData = await cds
            .transaction(req)
            .run(
                INSERT.into("com.logali.Header").entries({
                    Id: req.data.Id,
                    Email: req.data.Email,
                    FirstName: req.data.FirstName,
                    LastName: req.data.LastName,
                    Country: req.data.Country,
                    CreatedOn: req.data.CreatedOn,
                    DeliveryDate: req.data.DeliveryDate,
                    OrderStatus: req.data.OrderStatus,
                    ImageUrl: req.data.ImageUrl
                })
            )
            .then((resolve, reject) => {
                console.log("Resolve", resolve);
                console.log("Reject", reject);

                if (typeof resolve !== "undefined") {
                    return req.data;
                } else {
                    req.error(409, "Record Not Inserted");
                }
            })
            .catch((err) => {
                console.log(err);
                req.error(err.code, err.message);
            });

        console.log("Before End", returnData);
        return returnData;
    });

    /* Update */
    srv.on("UPDATE", "Header", async (req) => {
        let returnData = await cds
            .transaction(req)
            .run([
                UPDATE("com.logali.Header", req.data.Id).set({
                    Email: req.data.Email,
                    FirstName: req.data.FirstName,
                    LastName: req.data.LastName,
                    Country: req.data.Country,
                    DeliveryDate: req.data.DeliveryDate,
                    OrderStatus: req.data.OrderStatus
                }),
            ])
            .then((resolve, reject) => {
                console.log("Resolve: ", resolve);
                console.log("Reject: ", reject);

                if (resolve[0] == 0) {
                    req.error(409, "Record Not Found");
                }
            })
            .catch((err) => {
                console.log(err);
                req.error(err.code, err.message);
            });

        console.log("Before End", returnData);
        return returnData;
    });

    /* Delete */
    srv.on("DELETE", "Header", async (req) => {
        let returnData = await cds
            .transaction(req)
            .run(
                DELETE.from("com.logali.Header").where({
                    Id: req.data.Id
                })
            )
            .then((resolve, reject) => {
                console.log("Resolve", resolve);
                console.log("Reject", reject);

                if (resolve !== 1) {
                    req.error(409, "Record Not Found");
                }
            })
            .catch((err) => {
                console.log(err);
                req.error(err.code, err.message);
            });

        console.log("Before End", returnData);
        return await returnData;
    });
}