<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.entity.*"%>
<%@ page import="com.service.*"%>
<%@ page import="com.service.impl.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
    <title>E-MAN 电子书推荐社区</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet"
          href="<c:url value='/resources/bootstrap/3.3.7/css/bootstrap.min.css'/>">
    <!-- <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">-->
    <script src="<c:url value='/resources/jquery/2.1.1/jquery.min.js'/>"></script>
    <script
            src="<c:url value='/resources/bootstrap/3.3.7/js/bootstrap.min.js'/>"></script>


    <link
            href="<c:url value='/resources/star-rating/css/star-rating.min.css'/>"
            media="all" rel="stylesheet" type="text/css" />
    <script
            src="<c:url value='/resources/star-rating/js/star-rating.min.js'/>"
            type="text/javascript"></script>
    <script src="<c:url value='/resources/chart/Chart.js'/>"
            type="text/javascript"></script>
    <script src="<c:url value='/resources/chart/Chart.bundle.min.js'/>"
            type="text/javascript"></script>

    <script>
        $(document).ready(function() {
            // 开始写 jQuery 代码...

        });
    </script>
</head>

<body>

<div class="container">
    <!-- 导航栏 -->
    <jsp:include page="head.jsp" />
    <!-- 面包屑导航栏 TODO: -->
    <ol class="breadcrumb">
        <li><a href="<c:url value='/'/>">主页</a></li>
        <li><a
                href="list.htm?classifyMain=${ebook.classifyMain}&start=0">${ebook.classifyMain}</a></li>
    </ol>

    <!-- 图书信息面板 -->
    <div class="panel panel-default">
        <!-- 带标题的面板 -->
        <div class="panel-heading">
            <h3 class="panel-title">${ebook.ename}</h3>
        </div>

        <div class="panel-body">
            <div style="float: left;">
                <img src="http://localhost:8080/EMANImgs/${ebook.imgAddress}"
                     class="img-responsive"
                     onerror="javascript:this.src='http://localhost:8080/EMANImgs/error.jpg'"
                     width="170px" />
            </div>
            <div class="row">
                <div class="col-md-4">
                    <p>作者:${ebook.author}</p>
                    <p>
                        类别:
                        <c:if test="${ebook.category != 'null'}">
                            <c:out value="${ebook.category}" />
                        </c:if>
                        <c:if test="${ebook.category == 'null'}">
                            暂无信息
                        </c:if>
                    </p>
                    <p>
                        出版社:
                        <c:if test="${ebook.publishingHouse != 'null'}">
                            <c:out value="${ebook.publishingHouse}" />
                        </c:if>
                        <c:if test="${ebook.publishingHouse == 'null'}">
                            暂无信息
                        </c:if>
                    </p>
                    <p>
                        提供方:
                        <c:if test="${ebook.provider != 'null'}">
                            <c:out value="${ebook.provider}" />
                        </c:if>
                        <c:if test="${ebook.provider == 'null'}">
                            暂无信息
                        </c:if>
                    </p>
                    <p>
                        字数:约
                        <c:if test="${ebook.words != null}">
                            <c:out value="${ebook.words}" />
                        </c:if>
                        <c:if test="${ebook.words == null}">
                            暂无信息
                        </c:if>
                        字
                    </p>

                    <p>
                        ISBN:
                        <c:if test="${ebook.ISBN != 'null'}">
                            <c:out value="${ebook.ISBN}" />
                        </c:if>
                        <c:if test="${ebook.ISBN == 'null'}">
                            暂无信息
                        </c:if>
                    </p>
                    <p>分类：${ebook.classifyMain}</p>

                </div>

                <div class="col-md-4">
                    <input id="input-ratingValue" type="number"
                           value="<%/*将0~10之间的评分化为0~5之间的评分*/
			EBook ebook = (EBook) request.getAttribute("ebook");
			double t = 0.0;
			if (ebook.getRatingValue() == null) {

			} else {
				t = (ebook.getRatingValue() / 2);
			}
			int i = (int) t;
			double f = t - i;
			if (f >= 0.8)
				f = 1;
			else if (f < 0.3)
				f = 0;
			else
				f = 0.5;
			double rating = i + f;
			out.print(rating);%>" />

                    <p>
                        综合评分:
                        <c:if test="${ebook.ratingValue != null}">
                            <c:out value="${ebook.ratingValue}" />
                        </c:if>
                        <c:if test="${ebook.ratingValue == null}">
                            暂无信息
                        </c:if>
                        <span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
                        <c:if test="${ebook.reviewCount != null}">
                            <c:out value="${ebook.reviewCount}" />
                            人评价
                        </c:if>
                        <c:if test="${ebook.reviewCount == null}">
                            评分人数不足
                        </c:if>
                    </p>


                </div>
            </div>
        </div>
    </div>

    <!-- 数据面板 -->
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">评分数据图表</h3>
        </div>
        <div class="panel-body">
            <div class="col-xs-6">
                <!-- 饼图 -->
                <div id="canvas-holder" style="width:100%">
                    <canvas id="chart-area" />
                </div>
            </div>
            <div class="col-xs-6">
                <!-- 雷达图 -->
                <div id="canvas-holder-1" style="width:100%">
                    <canvas id="reviewCountAdvance-Chart"></canvas>
                </div>
            </div>
        </div>
    </div>



    <!-- 图书简介面板 -->
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">作品信息</h3>
        </div>
        <div class="panel-body">${ebook.description}</div>
    </div>

    <!-- 搜索图书面板 -->
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">搜索图书</h3>
        </div>

        <div class="row">
            <div class="col-md-1">
                <div class="panel-body">
                    <button id="gojd-btn" class="btn btn-primary" type="button">京东</button>
                </div>
            </div>

            <div class="col-md-1">
                <div class="panel-body">
                    <button id="gotaobao-btn" class="btn btn-primary" type="button">淘宝</button>
                </div>
            </div>

            <div class="col-md-1">
                <div class="panel-body">
                    <button id="gotianmao-btn" class="btn btn-primary" type="button">天猫</button>
                </div>
            </div>

            <div class="col-md-1">
                <div class="panel-body">
                    <button id="douban-btn" class="btn btn-primary" type="button">豆瓣</button>
                </div>
            </div>

            <div class="col-md-1">
                <div class="panel-body">
                    <button id="gozhangyue-btn" class="btn btn-primary" type="button">掌阅书库</button>
                </div>
            </div>

            <div class="col-md-1">
                <div class="panel-body">
                    <button id="wikipedia-btn" class="btn btn-primary" type="button">维基百科</button>
                </div>
            </div>

            <div class="col-md-1">
                <div class="panel-body">
                    <button id="panc-btn" class="btn btn-primary" type="button">胖次网盘</button>
                </div>
            </div>

        </div>
    </div>

    <!-- 推荐面板 -->
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">喜欢这本书的人还喜欢...</h3>
        </div>
        <div class="panel-body">
            <div class="row" id="similarityEBooks-panel">
                <div class="col-md-3" style="width: 15%;" id="book-example-div">
                    <div class="panel panel-default">
                        <div style="margin:0px auto">
                            <img width="100%"
                                 attr="http://localhost:8080/EMANImgs/error.jpg"
                                 onerror="javascript:this.src='http://localhost:8080/EMANImgs/error.jpg'">
                            <a href="#" id="ename"></a>
                            <p id="author"></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 评论面板 -->
    <h3>评论区</h3>
    <hr />
    <!-- 你的评论 -->
    <div class="panel panel-default" id="myDescribe-panel">
        <div class="panel-heading">
            <h3 class="panel-title">你的评论</h3>
        </div>
        <div class="panel-body" id="myDescribe-div">登录后才可评论</div>
    </div>

    <!-- 评论列表 -->
    <ul class="list-group" id="commentList">
        <li class="list-group-item" id="comment">
            <div>
                <h4>用户名</h4>
                <input id="rating-lisit-1" type="number" value="5" />
                <p class="rdescribe">评论</p>
            </div>
        </li>
    </ul>

    <!-- 翻页按钮 -->
    <div class="row">
        <button id="backpage-btn" class="btn btn-primary" type="button">上一页</button>
        <!-- 快速翻页按钮位置 -->
        <span>&nbsp;&nbsp;</span>
        <button id="nextpage-btn" class="btn btn-primary" type="button">下一页</button>
        <span>&nbsp;&nbsp;</span>
        <!-- 当前显示评论条数与总条数 -->
        <span id="curNum-p"></span><span>/</span><span id="totalNum-p"></span><span>条</span>
    </div>

</div>
<!-- container -->

<script>
    var uid = '<%=session.getAttribute("uid")%>';
    var state = '<%=session.getAttribute("state")%>';

    function queryOneDescribe(){
        $.ajax({
            url:"/EMAN/ratinglist/queryOne.htm",
            type:"get",
            data:"eid=${ebook.eid}&uid=<%=session.getAttribute("uid")%>",
            dataType:"json",
            success:function(data){
                var ratingListObject = data;

                $("#myDescribe-div").empty();

                if(ratingListObject == null || ratingListObject.rdescribe == null){ // 若没有评论 <input id="rating-input" type="number" />
                    $("#myDescribe-div").append("<div class=\"col-md-7\"><textarea class=\"form-control\" rows=\"5\" id=\"myDescribe-textarea\" /></div><div class=\"col-md-4\"><input id=\"rating-input\" type=\"number\" /></div><button id=\"submitMyDescribe-btn\" class=\"btn btn-primary\" type=\"button\">提交</button>");
                    //$("#myDescribe-div").append("<textarea class="form-control" rows="5" id="myDescribe-textarea">");
                    //TODO
                    /*登录用户评分*/
                    $('#rating-input').rating({
                        min: 0,
                        max: 5,
                        step: 0.5,
                        size: 'xs',
                        showClear: false
                    });
                    $("#submitMyDescribe-btn").click(function(){
                        var rdescribe = $("#myDescribe-textarea").val();
                        var ratingValue = $("#rating-input").val();
                        console.log("rdescribe=" + rdescribe);
                        console.log("ratingValue=" + ratingValue);

                        // 发送用户评分与评论
                        $.ajax({
                            url:"/EMAN/ratinglist/insert.htm",
                            type:"post",
                            data:{
                                eid:"${ebook.eid}",
                                uid:"<%=session.getAttribute("uid")%>",
                                rdescribe:rdescribe,
                                ratingValue:ratingValue
                            },
                            dataType:"json",
                            success:function(data){
                                var ratingListObject = data;
                                window.location.href = window.location.href;
                            },
                            error:function(){
                                alert("ajax请求失败");
                            }
                        });
                    });
                    /*评分修改触发函数*/
                    /*$('#rating-input').on('rating.change', function(event, value, caption) {
                        //检查用户是否登录,若登录且未评分则可以发送评分请求,否则弹出相应提示
                        if(state == "login"){ // 若用户已登录
                            // 发送修改评分请求
                        }
                        console.log(value);
                        console.log(caption);
                    });*/

                }else{
                    $("#myDescribe-div").append("<p>" + ratingListObject.rdescribe + "</p>");
                    $("#myDescribe-div").append("<input id=\"rating-input\" type=\"number\" value=\"\"/>");
                    $("#rating-input").attr("value", ratingListObject.ratingValue);
                    $("#rating-input").rating({
                        min: 0,
                        max:5,
                        step: 0.5,
                        size: 's',
                        readonly: true,
                        showClear: false
                    });

                }

            },
            error:function(){
                alert("ajax请求失败");
            }
        });


    }

    function getPie() {
        /*饼图插件*/
        var ctx = document.getElementById("chart-area").getContext("2d");
        // 获取数据
        $.ajax({
            url:"/EMAN/ratinglist/getEBookReviewCountPieChartData.htm",
            type:"get",
            data:"eid=${ebook.eid}",
            dataType:"json",
            success:function(data){
                window.myPie = new Chart(ctx, data);
                console.log(data);
            },
            error:function(){
                alert("ajax请求失败");
            }
        });
    }

    function getRader(){
        /*雷达图插件*/
        var ctx1 = document.getElementById("reviewCountAdvance-Chart").getContext("2d");
        // 获取数据
        $.ajax({
            url:"/EMAN/ratinglist/getEBookReviewCountRadarChartData.htm",
            type:"get",
            data:"eid=${ebook.eid}",
            dataType:"json",
            success:function(data){
                //data.datasets[0].backgroundColor="rgb(255, 99, 132).alpha(0.2).rgbString()";
                //data.datasets[0].borderColor=window.chartColors.red;
                //data.datasets[0].pointBackgroundColor=window.chartColors.red;
                window.myRadar = new Chart(ctx1, data);
                console.log(data);
            },
            error:function(jqXHR, textStatus, errorThrown){
                console.log("textStatus:"+textStatus+",errorThrown="+errorThrown);
                // alert("ajax请求失败");
                //location.reload();// 不知道为什么第一次请求雷达图会报错
            }
        });
    }

    $(document).on('ready', function () {

        /* 图书评分星星插件 */
        /*显示综合评分*/
        $("#input-ratingValue").rating({
            min: 0,
            max:5,
            step: 0.5,
            size: 'xs',
            readonly: true,
            showClear: false
        });


        setTimeout(getPie, 10);
        setTimeout(getRader, 200);




        /*判断用户登录则可评论*/
        if(state == "login"){ // 若用户已登录
            // 向服务器请求评论
            queryOneDescribe();
        }


        /*评论评分区AJAX数据获取*/
        $.ajax({
            url:"/EMAN/ratinglist/listLimit.htm",
            type:"get",
            data:"eid=${ebook.eid}&start=0",
            dataType:"json",
            success:function(data){
                var commentList = data;
                var clone = $("#comment").clone();
                $("#commentList").empty();

                if(commentList.length < 1){ // 若无数据
                    $("#commentList").append("<p>暂无评论</p>");
                }

                for(var i = 0; i < commentList.length; i++){
                    var cloneDiv = clone.clone();
                    cloneDiv.attr("id","comment"+(i+1));
                    cloneDiv.find("h4").text(commentList[i].user.uname);
                    cloneDiv.find("h4").attr("id",commentList[i].user.uid);
                    cloneDiv.find("input").attr("id","rating-"+(i+1));
                    cloneDiv.find("input").attr("value",commentList[i].ratingValue);
                    cloneDiv.find("input").rating({
                        min: 0,
                        max: 5,
                        step: 0.5,
                        size: 's',
                        readonly: true,
                        showClear: false
                    });
                    cloneDiv.find(".rdescribe").text(commentList[i].rdescribe);
                    $("#commentList").append(cloneDiv);
                }
            },
            error:function(){
                alert("ajax请求失败");
            }
        });

        /*评论评分区AJAX数据条数获取*/
        $.ajax({
            url:"/EMAN/ratinglist/listLimitCount.htm",
            type:"get",
            data:"eid=${ebook.eid}",
            dataType:"json",
            success:function(data){
                $("#curNum-p").text(0);
                $("#totalNum-p").text(data);
            },
            error:function(){
                alert("ajax请求失败");
            }
        });

        /* 翻页按钮动作 */
        $("#backpage-btn").click(function(){
            var curNum = parseInt($("#curNum-p").text());
            var totalNum = parseInt($("#totalNum-p").text());
            if(curNum < 20){
                alert("已是第一页");
            }else{
                curNum -= 20;
                $("#curNum-p").text(curNum);
            }

            $.ajax({
                url:"/EMAN/ratinglist/listLimit.htm",
                type:"post",
                data:{
                    eid:"${ebook.eid}",
                    start:curNum},
                dataType:"json",
                success:function(data){
                    var commentList = data;
                    var clone = $("#comment1").clone();
                    clone.find(".rating-container").remove();
                    clone.find("h4").after("<input id=\"rating-lisit-1\" type=\"number\" value=\"5\"/>");
                    $("#commentList").empty();

                    if(commentList.length < 1){ // 若无数据
                        $("#commentList").append("<p>暂无评论</p>");
                    }

                    for(var i = 0; i < commentList.length; i++){
                        var cloneDiv = clone.clone();
                        cloneDiv.attr("id","comment"+(i+1));
                        cloneDiv.find("h4").text(commentList[i].user.uname);
                        cloneDiv.find("h4").attr("id",commentList[i].user.uid);
                        cloneDiv.find("input").attr("id","rating-"+(i+1));
                        cloneDiv.find("input").attr("value",commentList[i].ratingValue);
                        cloneDiv.find("input").rating({
                            min: 0,
                            max: 5,
                            step: 0.5,
                            size: 's',
                            readonly: true,
                            showClear: false
                        });
                        cloneDiv.find(".rdescribe").text(commentList[i].rdescribe);
                        $("#commentList").append(cloneDiv);
                    }
                },
                error:function(){
                    alert("ajax请求失败");
                }
            });

        });
        $("#nextpage-btn").click(function(){
            var curNum = parseInt($("#curNum-p").text());
            var totalNum = parseInt($("#totalNum-p").text());
            if(curNum <= totalNum - 20){
                curNum += 20;
                $("#curNum-p").text(curNum);
            }else{
                alert("已是尾页");
            }

            $.ajax({
                url:"/EMAN/ratinglist/listLimit.htm",
                type:"post",
                data:{
                    eid:"${ebook.eid}",
                    start:curNum},
                dataType:"json",
                success:function(data){
                    var commentList = data;
                    var clone = $("#comment1").clone();
                    clone.find(".rating-container").remove();
                    clone.find("h4").after("<input id=\"rating-lisit-1\" type=\"number\" value=\"5\"/>");
                    $("#commentList").empty();

                    if(commentList.length < 1){ // 若无数据
                        $("#commentList").append("<p>暂无评论</p>");
                    }

                    for(var i = 0; i < commentList.length; i++){
                        var cloneDiv = clone.clone();
                        cloneDiv.attr("id","comment"+(i+1));
                        cloneDiv.find("h4").text(commentList[i].user.uname);
                        cloneDiv.find("h4").attr("id",commentList[i].user.uid);
                        cloneDiv.find("input").attr("id","rating-"+(i+1));
                        cloneDiv.find("input").attr("value",commentList[i].ratingValue);
                        cloneDiv.find("input").rating({
                            min: 0,
                            max: 5,
                            step: 0.5,
                            size: 's',
                            readonly: true,
                            showClear: false
                        });
                        cloneDiv.find(".rdescribe").text(commentList[i].rdescribe);
                        $("#commentList").append(cloneDiv);
                    }
                },
                error:function(){
                    alert("ajax请求失败");
                }
            });

        });


    });

    /* 与这本书相似度高的图书 */
       $.ajax({
            url : "/EMAN/ebook/similarityEBooks.htm",
            type : "get",
            data : {eid:"${ebook.eid}"},
            dataType : "json",
            success : function(data) {
                var listObject = data;
                var clone = $("#book-example-div").clone();
                $("#similarityEBooks-panel").empty();

                if (listObject.length < 1) { // 若无数据
                    $("#similarityEBooks-panel").append("<p>暂无推荐</p>");
                }

                for (var i = 0; i < listObject.length && i < 6; i++) {
                    var cloneDiv = clone.clone();
                    cloneDiv.attr("id", "book" + (i + 1));
                    cloneDiv.find("img").attr("src", "http://localhost:8080/EMANImgs/" + listObject[i].imgAddress);
                    cloneDiv.find("#ename").attr("href", "http://localhost:8080/EMAN/ebook/info.htm?eid=" + listObject[i].eid);
                    cloneDiv.find("#ename").text(listObject[i].ename);

                    cloneDiv.find("#author").text(listObject[i].author);

                    $("#similarityEBooks-panel").append(cloneDiv);
                }

            },
            error : function() {
                alert("ajax请求失败");
            }
        });


    $(function() {

        /* 搜索图书面板按钮动作 */
        $("#gojd-btn").click(function(){
            window.location.href = "https://search.jd.com/Search?keyword=" + "${ebook.ename}" + "&enc=utf-8";
        });

        $("#gotaobao-btn").click(function(){
            window.location.href = "https://s.taobao.com/search?q=" + "${ebook.ename}" + "&ie=utf8";
        });

        $("#gotianmao-btn").click(function(){
            window.location.href = "https://list.tmall.com/search_product.htm?q=" + "${ebook.ename}";
        });

        $("#gozhangyue-btn").click(function(){
            window.location.href = "http://www.ireader.com/index.php?ca=search.index&pca=bookdetail.index&keyword=" + "${ebook.ename}";
        });

        $("#douban-btn").click(function(){
            window.location.href = "https://read.douban.com/ebook/" + "${ebook.eid}";
        });

        $("#panc-btn").click(function(){
            window.location.href = "http://www.panc.cc/s/" + "${ebook.ename}" + "/td_0";
        });

        $("#wikipedia-btn").click(function(){
            window.location.href = "https://en.wikipedia.org/wiki/" + "${ebook.ename}";
        });

    });
</script>
</body>