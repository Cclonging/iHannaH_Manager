//设置show_account
$('#show_account').html(sessionStorage.getItem("admin"));

$('#quit').click(function () {
    sessionStorage.removeItem("admin");
});

//获取ManagePage页面所需要的数据
$.ajax({
    type: "GET",
    url: "/data/getManagePageData",
    dataType: "json",
    success: function (result) {
        if (result.status == 200){
            var data = result.data;
            $('#totalUsers').html(data.userNums);
            $('#server_max').html(data.smaxNums);
            $('#curIlle').html(data.illegalNums);
            $('#curUsers').html(data.banNums);
        }else {
            $('#totalUsers').html(0);
            $('#server_max').html(0);
            $('#curIlle').html(0);
            $('#curUsers').html(0);
        }
    }
});



