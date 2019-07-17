var speed_x = Math.random()*10-5;
        var speed_y = Math.random()*10-5;
        console.log("RUNING START");
        toNextPosition("text",400,400);
        function toNextPosition(idname,width,height)
        {
        //var element = document.getElementById(idname);
        //console.log(element);
        var left = document.getElementById(idname).style.left;
        var top = document.getElementById(idname).style.right;
        if(left == 0 || left == width) //Bounce back
            {
                speed_x = -speed_x;
            }
        if(top == 0 || top == height)
            {
                speed_y = -speed_y;
            }

        if(left + speed_x < 0)
            {
                element.setAttribute("left",0);
            }
        if(left + speed_x > width)
            {
                element.setAttribute("left",width);
            }
        else
            {
                element.setAttribute("left",left + speed_x );
            }

        if(top + speed_y < 0)
            {
                element.setAttribute("top",0);
            }
        if(left + speed_y > height)
            {
                element.setAttribute("top",height);
            }
        else
            {
                element.setAttribute("top",top + speed_y);
            }    
        }