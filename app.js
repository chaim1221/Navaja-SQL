var exec = require("child_process").exec;
var fs = require("fs");
var errorMessage = "";

var child = function (cmd, msg, callback) {
    exec(cmd, function (error, stdout, stderr) {
       if (stdout) {
           console.log('stdout: ' + stdout);
       }

       if (stderr) {
          if (stderr.indexOf('syntax error') > -1) {
              errorMessage += '\n' + stderr;
          }
          console.log('stderr: ' + stderr);
       }

       if (error) {
           console.log('exec err: ' + error);
       }

       callback('success: ' + msg);
    });
}

var copyFile = function (source, target, callback) {
    var finished = false;

    var fileToRead = fs.createReadStream(source);
    fileToRead.on("error", done);

    var fileToWrite = fs.createWriteStream(target);
    fileToWrite.on("error", done);
    fileToWrite.on("close", function (error) {
        done();
    });

    fileToRead.pipe(fileToWrite);
    
    function done(err) {
       if (!finished) {
           callback(err);
           finished = true;
       }
   }
}

function createUser (callback) { 
    child("psql -U postgres -d postgres -a -f machete-db-user.sql", "Created DB user.", callback);
}

function configFiles (callback) {
    var pghbaconf = false;
    var pgpass = false;
    
    copyFile('./.pgpass', process.env.HOME + '/.pgpass', function () {
       pgpass = true;
       alldone();
    });

    copyFile('./pg_hba.conf', '/etc/postgresql/9.4/main/pg_hba.conf', function () {
       pghbaconf = true;
       alldone();
    });

    function alldone() {
        if (pghbaconf && pgpass) {
            child("service postgresql restart", "Config files transferred.", callback);
        }
    }
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

configFiles(function (callback) { 
    console.log(callback); 
    createUser(function (callback) {
        console.log(callback);
        createDb(function (callback) {
            console.log(callback);
            createEmployer(function (callback) {
                console.log(callback);
                createWorker(function (callback) {
                    console.log(callback);
                    createWork(function (callback) {
                        console.log(callback);
                        if (errorMessage) throw new Error(errorMessage);
                    });
                });
            });
        });
    });
});
