var exec = require("child_process").exec;
var fs = require("fs");

var child = function (cmd, msg, callback) {
    exec(cmd, function (error, stdout, stderr) {
       console.log('stdout: ' + stdout);
       console.log('stderr: ' + stderr);
       if (error !== null) console.log('exec err: ' + error);
       callback('success: ' + msg);
    });
}

function createUser (callback) { 
    child("psql -U postgres -d postgres -a -f machete-db-user.sql", "Created DB user.", callback);
}

function savePassword (callback) {
    fs.appendFile(process.env.HOME + "/.pgpass", "*:*:machetedb:machetedb_app_user:replace_me\n", callback("Appended password to .pgpass file."));
}

function createDb (callback) {
    child("export PGPASSWORD='replace_me'; psql -U machetedb_app_user -d postgres -a -f machete-db.sql; export PGPASSWORD=''", "Created DB.", callback);
}

function createEmployer (callback) {
    child("psql -U machetedb_app_user -d machetedb -a -f machete-employer.sql", "Created employer schema.", callback);
}

function createWorker (callback) {
    child("psql -U machetedb_app_user -d machetedb -a -f machete-worker.sql", "Created worker schema.", callback);
}

function createWork (callback) {
    child("psql -U machetedb_app_user -d machetedb -a -f machete-work.sql", "Created work schema.", callback);
}

createUser(function (callback) { 
    console.log(callback); 
    savePassword(function (callback) {
        console.log(callback);
        createDb(function (callback) {
            console.log(callback);
            createEmployer(function (callback) {
                console.log(callback);
                createWorker(function (callback) {
                    console.log(callback);
                    createWork(function (callback) {
                        console.log(callback);
                    });
                });
            });
        });
    });
});
