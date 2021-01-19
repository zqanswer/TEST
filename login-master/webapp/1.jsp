<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>贪吃蛇</title>
    <style>
        #map{
            width: 400px;
            height: 400px;
            border: 1px solid black;
        }
        /*地图颜色*/
        .divMap{
            width: 18px;
            height: 18px;
            margin: 1px;
            background-color: pink;
            float: left;
        }
        /*蛇身颜色*/
        .divSnake{
            width: 18px;
            height: 18px;
            margin: 1px;
            background-color: deepskyblue;
            float: left;
        }
        /*食物颜色*/
        .divFood{
            width: 18px;
            height: 18px;
            margin: 1px;
            background-color: darkseagreen;
            float: left;
        }
    </style>
    <script>
        var mapX=20;
        var mapY=20; //地图边界，横向和纵向的div小格
        var arrMap=new Array();//地图数组
        var snackeX = [4,5,6,7],snackeY=[2,2,2,2];//蛇身初始化坐标值
        var foodX,foodY; //创建食物坐标
        var keyCode = 39;//蛇身移动方向,默认向右

        //创建地图
        function createMap() {
            //获取地图外框div
            var map=document.getElementById("map");
            //地图创建div小格，横纵各20个
            for(y=0;y<mapY;y++)
            {
                arrMap[y]= new Array();
                for(x=0;x<mapX;x++)
                {
                    //div小格
                    var div =document.createElement("div");
                    div.className="divMap";//初始化样式
                    arrMap[y][x]=div;//将div小格放入地图数组中
                    map.appendChild(div);//页面绘制
                }
            }
        }

        //创建蛇身
        function createSnack(){
            //改变地图中一串连续div底色
            for(i=0;i<snackeX.length;i++)
            {
                arrMap[snackeY[i]][snackeX[i]].className ="divSnake";
            }
        }
        //清除蛇身
        function clearSnack() {
            for(i=0;i<snackeX.length;i++)
            {
                arrMap[snackeY[i]][snackeX[i]].className="divMap";
            }
        }
        //创建食物
        function createFood()
        {
            //arrMap[foodY][foodX].className="divFood";
            var result;//判断是否要重新生成食物
            do {
                result = false;//默认不重叠
                //随机食物坐标
                foodX=parseInt(Math.random()*mapX);
                foodY=parseInt(Math.random()*mapY);

                //判断食物不能出现在蛇身上
                for(i=0;i>snackeX.length;i++) {
                    if(snackeX[1]==foodX&&snackeY[1]==foodY)
                    {
                        result = true;//需要重新生成
                        break;
                    }
                }

            }while(result);
            arrMap[foodY][foodX].className="divFood";
        }
        //蛇身运动
        //1.清除蛇身
        //2.移动蛇身坐标，增加蛇头，清除蛇尾一格
        function snackMove() {
            //清除蛇身
            clearSnack();
            for (i = 0; i < snackeX.length - 1; i++) {
                snackeX[i] = snackeX[i + 1];
                snackeY[i] = snackeY[i + 1];
            }
            //每次移动，蛇头增加一格， keyCode匹配键盘方向
            switch (keyCode) {
                case 37://向左
                    snackeX[snackeX.length - 1]--;
                    break;
                case 38://向上
                    snackeY[snackeY.length - 1]--;
                    break;
                case 39://向右
                    snackeX[snackeX.length - 1]++;
                    break;
                case 40://向下
                    snackeY[snackeY.length - 1]++;
                    break;

            }
            //吃食物
            if (snackeX[snackeX.length - 1] == foodX && snackeY[snackeY.length - 1] == foodY)
            {
                //吃到食物
                snackeX[snackeX.length]=snackeX[snackeX.length-1];
                snackeY[snackeY.length]=snackeY[snackeY.length-1];
                //重新排列蛇身
                for(i=snackeX.length-1;i>0;i--)
                {
                    snackeX[i]=snackeX[i-1];
                    snackeY[i]=snackeY[i-1];
                }
                createFood();//重新生成下一个食物
            }
            //超出游戏边框
            if(snackeX[snackeX.length-1]<0
                || snackeX[snackeX.length-1]>mapX-1
                || snackeY[snackeY.length-1]<0
                || snackeY[snackeY.length-1]>mapY-1)
            {
                clearInterval(move);//停止移动
                return ;
            }

            createSnack();//重新创建蛇身
        }
        //键盘事件
        function keyDown(){
            var newKey = event.keyCode//键盘按键
            if(keyCode == 37 && newKey == 39||
                keyCode == 39 && newKey == 37||
                keyCode == 38 && newKey == 40||
                keyCode == 40 && newKey == 38
            ) {
                //禁止掉头
                return ;
            } else if(newKey>=37&&newKey<=40){
                //用户按了某个方向键
                keyCode=newKey;
            }
            else{
                //其他按键
            }
        }
        //运行
        window.onload =function () {
            createMap(); //创建地图
            createSnack();//创建蛇身
            createFood();//创建食物

            move= setInterval("snackMove()",200)//蛇身移动
            document.onkeydown = keyDown;//获取方向键
        }
    </script>
</head>
<body>
<div id="map"></div>
</body>
</html>
