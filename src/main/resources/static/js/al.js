//页面渲染
window.al = {

    //渲染allUsers
    renderContent2AllUsers: function (page) {
        console.log("allUsers has been clicked");
        console.log("page: " + page)
        $.ajax({
            type: "GET",
            url: "/data/getAllUsers?curPage=" + page,
            dataType: "json",
            success: function (result) {
                if (result.status == 500){
                    $(window).attr('location',"/error");
                }
                if (result.status == 200){
                    var data = result.data.users;
                    var htmls = "<div class=\"row\">" +
                        "                <div class=\"col-md-12\">" +
                        "                    <div class=\"card\">" +
                        "                        <div class=\"card-header bg-light \">" +
                        "                            <div style=\"float:left; width:20%\"><h2>所有用户表</h2></div>" +
                        "<div class=\"input-group\" style=\"float:left; width:60%\">" +
                        "                                            <input type=\"text\" id='id_username' name='id_username' class=\"form-control\" placeholder=\"输入用户id\">" +
                        "                                            <span class=\"input-group-btn\">" +
                        "                                                <button type=\"button\" class=\"btn btn-primary\" id='search_id' onclick='al.searchUserById();'><i class=\"fa fa-search\"></i>查询</button>" +
                        "                                            </span>" +
                        "                                        </div>" +
                        "                        </div>" +
                        "" +
                        "                        <div class=\"card-body\">" +
                        "                            <div class=\"table-responsive\">" +
                        "                                <table class=\"table\">" +
                        "                                    <thead>" +
                        "                                    <tr>" +
                        "                                        <th>序号</th>" +
                        "                                        <th>id</th>" +
                        "                                        <th>用户名</th>" +
                        "                                        <th>昵称</th>" +
                        "                                        <th>所在服务器</th>" +
                        "                                        <th>状态</th>" +
                        "                                        <th>操作</th>" +
                        "                                    </tr>" +
                        "                                    </thead>" +
                        "                                    <tbody>";
                        var serverName = result.data.serverName;
                        for (var i = 0; i < data.length; i++){
                            htmls += "<tr><td>" + (i + 1) +
                                "</td><td class='text-nowrap'><a onclick=\"al.openModel('" + data[i].id +"')\">" + data[i].id + "</a></td><td>" + data[i].username +
                                "</td><td>" + data[i].nickname + "</td><td>" + serverName +
                                "</td><td>在线</td><td><button class='btn btn-rounded btn-warning' onclick=\"al.banUser('"+ data[i].id + "','" + data[i].username + "')\">封号</button></td></tr>";
                        }
                        var page = result.data.page;
                        var curPage = page.curPage;
                        var totalPage = page.totalPage;
                        var prePage = curPage-1 < 0 ? 0 : (curPage - 1);
                        var nextPage = curPage+1>totalPage ? totalPage : (curPage + 1);
                        htmls +="                                    </tbody>" +
                        "                                </table>" +
                        "                            </div>" +
                        "<div class=\"col-md-12\">" +
                        "<div style=\"float:left; width:10%\">" +
                        "<p>" + (curPage+1) + " / " + (totalPage+1) +" </p>" +
                        "</div>" +
                        "<div style=\"float:left; width:35%\">" +
                        "<button class=\"btn btn-rounded btn-primary\" onclick='al.renderContent2AllUsers(0)'>首页</button>" +
                        "<button class=\"btn btn-rounded btn-primary\" onclick='al.renderContent2AllUsers("+ prePage + ")'>上一页</button>" +
                        "<button class=\"btn btn-rounded btn-primary\" onclick='al.renderContent2AllUsers(" + nextPage + ")'>下一页</button>" +
                        "<button class=\"btn btn-rounded btn-primary\" onclick='al.renderContent2AllUsers(" + totalPage + ")'>尾页</button>" +
                        "</div>" +
                        "" +
                        "<div style=\"float:right;width:50%\">" +
                        "<div style=\"float:right; width:50%\" >" +
                        "<select id='pageSelector' class=\"form-control col-md-3\">";

                        for (var i=1; i <= totalPage+1; i++){
                            if ((i - 1) == curPage)
                                htmls += "<option selected='selected' value='"+ (i-1) +"'>" + i + "</option>";
                            else
                                htmls += "<option value='"+ (i-1) +"'>" + i + "</option>";
                        }
                        htmls += "</select>" +
                        "</div>" +
                        "<div style=\"float:right;\">" +
                        "<button class=\"btn btn-rounded btn-success\" onclick=\"al.renderContent2AllUsers($('#pageSelector').val())\">Go</button>" +
                        "</div>" +
                        "</div>" +
                        "</div>" +
                        "                        </div>" +
                        "                    </div>" +
                        "                </div></div>";
                    $('#content').empty().append(htmls);
                    $(document).keyup(function(event){
                        if(event.keyCode ==13){
                            $("#search_id").trigger("click");
                        }
                    });
                }
            }
        });

    },

    //渲染illegal
    renderContent2Illegal: function (page) {
        var htmls = '';
        $.ajax({
            type: "GET",
            url: "/mg/all?curPage=" + page,
            dataType: "json",
            success: function (result) {
                if (result.status == 500){
                    htmls = result.msg;
                }
                if (result.status == 200){
                    var iRs = result.data.remarks;
                    var htmls = "<div class=\"row\">" +
                        "                <div class=\"col-md-12\">" +
                        "                    <div class=\"card\">" +
                        "                        <div class=\"card-header bg-light \">" +
                        "                            <div style=\"float:left; width:20%\"><h2>违规言论</h2></div>" +
                        "<div class=\"input-group\" style=\"float:left; width:60%\">" +
                        "                                            <input type=\"text\" id='ir_username' name='ir_username' class=\"form-control\" placeholder=\"输入id\">" +
                        "                                            <span class=\"input-group-btn\">" +
                        "                                                <button type=\"button\" class=\"btn btn-primary\" id='search_id' onclick='al.searchUserById();'><i class=\"fa fa-search\"></i>查询</button>" +
                        "                                            </span>" +
                        "                                        </div>" +
                        "                        </div>" +
                        "" +
                        "                        <div class=\"card-body\">" +
                        "                            <div class=\"table-responsive\">" +
                        "                                <table class=\"table\">" +
                        "                                    <thead>" +
                        "                                    <tr>" +
                        "                                        <th>序号</th>" +
                        "                                        <th>id</th>" +
                        "                                        <th>内容</th>" +
                        "                                        <th>发送者</th>" +
                        "                                        <th>接收者</th>" +
                        "                                        <th>日期</th>" +
                        "                                        <th>操作</th>" +
                        "                                    </tr>" +
                        "                                    </thead>" +
                        "                                    <tbody>";
                    for (var i = 0; i < iRs.length; i ++){
                        htmls += "<tr><td>" + (i + 1) +
                            "</td><td class='text-nowrap'><a  onclick='javascript:;'>" + iRs[i].id + "</a></td><td><a onclick=\"al.showContent('" + iRs[i].content + "')\">" + iRs[i].content.substr(0,3) + "..." +
                            "</a></td><td><a  onclick=\"al.openModel('" + iRs[i].senderId +"')\" >" + iRs[i].senderId + "</a></td><td><a  onclick=\"al.openModel('" + iRs[i].receiverId +"')\" >" + iRs[i].receiverId +
                            "</a></td><td>" + iRs[i].date + "</td><td><button class='btn btn-rounded btn-warning'>操作</button></td>";
                    }

                    var page = result.data.page;
                    var curPage = page.curPage;
                    var totalPage = page.totalPage;
                    var prePage = curPage-1 < 0 ? 0 : (curPage - 1);
                    var nextPage = curPage+1>totalPage ? totalPage : (curPage + 1);

                    htmls +="                                    </tbody>" +
                        "                                </table>" +
                        "                            </div>" +
                        "<div class=\"col-md-12\">" +
                        "<div style=\"float:left; width:10%\">" +
                        "<p>" + (curPage+1) + " / " + (totalPage+1) +" </p>" +
                        "</div>" +
                        "<div style=\"float:left; width:35%\">" +
                        "<button class=\"btn btn-rounded btn-primary\" onclick='al.renderContent2Illegal(0)'>首页</button>" +
                        "<button class=\"btn btn-rounded btn-primary\" onclick='al.renderContent2Illegal("+ prePage + ")'>上一页</button>" +
                        "<button class=\"btn btn-rounded btn-primary\" onclick='al.renderContent2Illegal(" + nextPage + ")'>下一页</button>" +
                        "<button class=\"btn btn-rounded btn-primary\" onclick='al.renderContent2Illegal(" + totalPage + ")'>尾页</button>" +
                        "</div>" +
                        "" +
                        "<div style=\"float:right;width:50%\">" +
                        "<div style=\"float:right; width:50%\" >" +
                        "<select id='pageSelector' class=\"form-control col-md-3\">";

                    for (var i=1; i <= totalPage+1; i++){
                        if ((i - 1) == curPage)
                            htmls += "<option selected='selected' value='"+ (i-1) +"'>" + i + "</option>";
                        else
                            htmls += "<option value='"+ (i-1) +"'>" + i + "</option>";
                    }
                    htmls += "</select>" +
                        "</div>" +
                        "<div style=\"float:right;\">" +
                        "<button class=\"btn btn-rounded btn-success\" onclick=\"al.renderContent2Illegal($('#pageSelector').val())\">Go</button>" +
                        "</div>" +
                        "</div>" +
                        "</div>" +
                        "                        </div>" +
                        "                    </div>" +
                        "                </div></div>";
                    $('#content').empty().append(htmls);
                }
            }
        });
    },

    //渲染Ban
    renderContent2Ban: function () {
        var htmls = '<h3>待开放，谢谢</h3>';
        $('#content').empty().append(htmls);
    },

    //渲染Active
    renderContent2Activie: function () {
        var htmls = '<h3>待开放，谢谢</h3>';
        $('#content').empty().append(htmls);
    },

    //渲染Resources
    renderContent2Resources: function () {
        var htmls = '<h3>待开放，谢谢</h3>';
        $('#content').empty().append(htmls);
    },

    //渲染Flow
    renderContent2Flow: function () {
        var htmls = '<h3>待开放，谢谢</h3>';
        $('#content').empty().append(htmls);
    },

    //渲染Vitality
    renderContent2Vitality: function () {
        var htmls = '<h3>待开放，谢谢</h3>';
        $('#content').empty().append(htmls);
    },

    searchUserById: function () {

        var id = $('#id_username').val();
        if (id.trim() == ""){
            alert("请输入");
            return;
        }

        al.requestApi(id, 0);
    },

    requestApi: function (id, page) {
        $.ajax({
            type: "GET",
            url: "/data/getUser?id=" + id + "&curPage=" + page,
            dataType: "json",
            success: function (result) {
                if (result.status == 500){
                    alert(result.msg);
                }else if (result.status == 200){
                    console.log(result.data);
                    var data = result.data.users;
                    var htmls = "<div class=\"row\">" +
                        "                <div class=\"col-md-12\">" +
                        "                    <div class=\"card\">" +
                        "                        <div class=\"card-header bg-light \">" +
                        "                            <div style=\"float:left; width:20%\"><h2>所有用户表</h2></div>" +
                        "<div class=\"input-group\" style=\"float:left; width:60%\">" +
                        "                                            <input type=\"text\" id='id_username' name='id_username' class=\"form-control\" placeholder=\"输入用户id\">" +
                        "                                            <span class=\"input-group-btn\">" +
                        "                                                <button type=\"button\" class=\"btn btn-primary\" onclick='al.searchUserById();'><i class=\"fa fa-search\"></i>查询</button>" +
                        "                                            </span>" +
                        "                                        </div>" +
                        "                        </div>" +
                        "" +
                        "                        <div class=\"card-body\">" +
                        "                            <div class=\"table-responsive\">" +
                        "                                <table class=\"table\">" +
                        "                                    <thead>" +
                        "                                    <tr>" +
                        "                                        <th>序号</th>" +
                        "                                        <th>id</th>" +
                        "                                        <th>用户名</th>" +
                        "                                        <th>昵称</th>" +
                        "                                        <th>所在服务器</th>" +
                        "                                        <th>状态</th>" +
                        "                                        <th>操作</th>" +
                        "                                    </tr>" +
                        "                                    </thead>" +
                        "                                    <tbody>";
                    var serverName = result.data.serverName;
                    for (var i = 0; i < data.length; i++){
                        htmls += "<tr><td>" + (i + 1) +
                            "</td><td class='text-nowrap'><a onclick=\"al.openModel('" + data[i].id +"')\">" + data[i].id + "</a></td><td>" + data[i].username +
                            "</td><td>" + data[i].nickname + "</td><td>" + serverName +
                            "</td><td>在线</td><td><button class='btn btn-rounded btn-warning' onclick=\"al.banUser('"+ data[i].id + "','" + data[i].username + "')\">封号</button></td></tr>";
                    }
                    var page = result.data.page;
                    var curPage = page.curPage;
                    var totalPage = page.totalPage;
                    var prePage = curPage-1 < 0 ? 0 : (curPage - 1);
                    var nextPage = curPage+1>totalPage ? totalPage : (curPage + 1);
                    htmls +="                                    </tbody>" +
                        "                                </table>" +
                        "                            </div>" +
                        "<div class=\"col-md-12\">" +
                        "<div style=\"float:left; width:10%\">" +
                        "<p>" + (curPage+1) + " / " + (totalPage+1) +" </p>" +
                        "</div>" +
                        "<div style=\"float:left; width:35%\">" +
                        "<button class=\"btn btn-rounded btn-primary\" onclick=\"al.requestApi('" + String(id) + ","+ 0 +")\">首页</button>" +
                        "<button class=\"btn btn-rounded btn-primary\" onclick=\"al.requestApi('" + String(id) + "',"+ prePage +")\">上一页</button>" +
                        "<button class=\"btn btn-rounded btn-primary\" onclick=\"al.requestApi('" + String(id) + "',"+ nextPage +")\">下一页</button>" +
                        "<button class=\"btn btn-rounded btn-primary\" onclick=\"al.requestApi('" + String(id) + "',"+ totalPage +")\">尾页</button>" +
                        "</div>" +
                        "" +
                        "<div style=\"float:right;width:50%\">" +
                        "<div style=\"float:right; width:50%\" >" +
                        "<select id='pageSelector' class=\"form-control col-md-3\">";

                    for (var i=1; i <= totalPage+1; i++){
                        if ((i - 1) == curPage)
                            htmls += "<option selected='selected' value='"+ (i-1) +"'>" + i + "</option>";
                        else
                            htmls += "<option value='"+ (i-1) +"'>" + i + "</option>";
                    }
                    htmls += "</select>" +
                        "</div>" +
                        "<div style=\"float:right;\">" +
                        "<button class=\"btn btn-rounded btn-success\" onclick=\"al.requestApi('" + String(id) + "'," + $('#pageSelector').val() +")\">Go</button>" +
                        "</div>" +
                        "<div style=\"float:right;\">" +
                        "<button class=\"btn btn-rounded btn-danger\" onclick=\"al.renderContent2AllUsers(0)\">返回</button>" +
                        "</div>" +
                        "</div>" +
                        "</div>" +
                        "                        </div>" +
                        "                    </div>" +
                        "                </div></div>";
                    $('#content').empty().append(htmls);

                }
            }
        });
    },

    //封禁账号
    banUser: function (id, username) {

        if (confirm("是否封禁 " + username + "(" + id + ")")){
            //TODO 后台交互，将这个id插入到后台hannah_dev的user_ban里面
            $(this).val("解封");

        }
    },

    /**
     * 打开模态框
     * @param id
     */
    openModel: function (id) {
        console.log(id);

        $.ajax({
            type: "GET",
            url: "/data/getUserByid?id=" + id,
            dataType: "json",
            success: function (result) {
                if (result.status == 500){
                    alert("500 " + result.msg);
                }
                if (result.status == 200){
                    var data = result.data;
                    var user = data.user;
                    $('#md_id').text(user.id);
                    $('#md_name').text(user.username);
                    $('#md_nick').text(user.nickname);
                    $('#md_face').text(user.faceImage);
                    $('#md_irs').text(data.illNums);
                    $('#md_status').text(data.status);
                    $('#md_dl').text(data.serverName);
                    $('#md_date').text(user.registeTime);
                }
            }
        });
        $('#myModal').modal('show');

    },

    showContent: function (content) {
        $('#model_detail').text(content);
        $('#conModel').modal('show');
    }

};
