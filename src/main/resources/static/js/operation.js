//登录
$('#submit').click(function () {
    login();
});

$(document).keyup(function(event){
    if(event.keyCode ==13){
        $("#submit").trigger("click");
    }
});


function login() {
    var com_account = $('#account');
    var com_pwd = $('#pwd');
    var account = com_account.val();
    var pwd = com_pwd.val();
    //console.log(account + pwd || pwd.length > 10)
    if (account.length > 10){
        alert("账号或密码不能超过10位" || pwd.length > 10);
        com_account.val("");
        com_pwd.val("");
        com_account.focus();
        return;
    }

    if (account.trim() == "" || pwd.trim() == ""){
        alert("请输入账号密码");
        com_account.val("");
        com_pwd.val("");
        com_account.focus();
        return;
    }
    $.ajax({
        type: "GET",
        url: "/data/login/" + account + "/" + pwd + "/info",
        dataType: "json",
        success: function (result) {
            if (result.status == 500){
                alert(result.msg);
                com_account.val("");
                com_pwd.val("");
                com_account.focus();
            }
            if (result.status == 200){
                sessionStorage.setItem("admin", result.data);
                $(window).attr('location',"/hh_manager");
            }
        }
    });
}