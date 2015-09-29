var exec = require("child_process").exec;
var fs = require("fs");
var err = function (error, stdout, stderr) { 
    console.log(error || "");
    console.log(stdout || "");
    console.log(stderr || "");
}

var returnedResults = main();
for (var i = 0; i < returnedResults.length; i++) {
    console.log(returnedResults[i]);
}
process.exit();

function main () {
    var results = [];
    results.push(createUser(err));
    results.push(createDb(err));
    results.push(createEmployer(err));
    results.push(createWorker(err));
    results.push(createWork(err));
    return results;
}

function createUser (err) { 
    try {
        console.log("Creating DB user...");
        exec("psql -U postgres -d postgres -a -f machete-db-user.sql", err);
        console.log("Appending DB user password to .pgpass file...");
        fs.appendFile(process.env.HOME + "/.pgpass", "*:*:machetedb:machetedb_app_user:replace_me\n", err);
        return "Successfully created DB user.";
    }
    catch (error) {
        return "Error creating DB user.";
    }
}

function createDb (err) {
    try {
        console.log("Creating DB...");
        exec("export PGPASSWORD='replace_me'; psql -U machetedb_app_user -d postgres -a -f machete-db.sql; export PGPASSWORD=''", err);
        return "Successfully created DB.";
    }
    catch (error) {
        return "Error creating DB.";
    }
}

function createEmployer (err) {
    try {
        console.log("Creating employer schema...");
        exec("psql -U machetedb_app_user -d machetedb -a -f machete-employer.sql", err);
        return "Successfully created employer schema.";
    }
    catch (error) {
        return "Error creating employer schema.";
    }
}

function createWorker (err) {
    try {
        console.log("Creating worker schema...");
        exec("psql -U machetedb_app_user -d machetedb -a -f machete-worker.sql", err);
        return "Successfully created worker schema.";
    }
    catch (error) {
        return "Error creating worker schema.";
    }
}

function createWork (err) {
    try {
        console.log("Creating work schema...");
        exec("psql -U machetedb_app_user -d machetedb -a -f machete-work.sql", err);
        return "Successfully created work schema.";
    }
    catch (error) {
        return "Error creating work schema.";
    }
}

