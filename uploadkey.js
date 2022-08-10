let OSS = require("ali-oss");
var exec = require('child_process').exec;
var http = require("http");
var querystring = require("querystring");
/* let client = new OSS({
  region: "oss-cn-hangzhou",
  accessKeyId: "LTAI5tCAs5WeySmxRrL8wfV7",
  accessKeySecret: "rGKQ28pkka5iuAH42iev5VPDvi4fPR",
  bucket: "yios-oss",
}); */
let client = new OSS({
  region: "oss-cn-hongkong",
  accessKeyId: "LTAI5tBGL31vFPinVuRz1cRa",
  accessKeySecret: "GIZIFdFu6FaoxuX4I1Kx5f8GeLJpxR",
  bucket: "yiosio",
});


async function put() {
  try {
    //object-name可以自定义为文件名（例如file.txt）或目录（例如abc/test/file.txt）的形式，实现将文件上传至当前Bucket或Bucket下的指定目录。
    let result = await client.put("client", "./client");
    console.info(result)
    return result;

  } catch (e) {
    console.log(e);
  }
}


async function uploadit() {
  await tarfile();
  var ossinfo = await put();

  console.info(ossinfo.res.headers.etag.replace("\"", "").replace("\"", ""))
  /*  checkupdate(ossinfo.res.headers.etag.replace("\"", "").replace("\"", ""), (resp) => {
     console.info(resp)
     console.info("done")
   }); */
}

uploadit()

/* function checkupdate(etag, callback) {
  var contents = querystring.stringify({
    etag: etag,
  })

  console.info(etag)
  var options = {
    host: "update.yios.cn",
    port: 10000,
    path: "/newupdate",
    method: "POST",
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Content-Length": contents.length,
    },
  };

  var req = http.request(options, function (res) {
    res.setEncoding("utf8");

    res.on("data", function (data) {

      callback(data);

    });
  });

  req.write(contents);
  req.end;
} */

function tarfile() {
  new Promise((resolve, reject) => {
    var cmd = 'tar -zcvf abc.tar.gz /root/.forta';
    exec(cmd, function (error, stdout, stderr) {
      resolve();
    });
  })

}

