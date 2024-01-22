const cds = require("@sap/cds");
const Header = cds.entities("com.logali.Header");

module.exports = function (srv) {
    srv.after("READ", "Header", async (req) => {
        console.log('hello there');
    });
}