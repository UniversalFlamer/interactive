//document.write("<p>initial.js loaded successfully!</p>");
function update(action)
{
    if(j < COLUMN_PIXEL_NUM)
    {
        action();
        j++;
    }
    else
        {
            j = 0;
            i++;
        }
    if(i == ROW_PIXEL_NUM)
        {
            i=0;
        }
    


}

function action_test()
{
    if(Math.random()< 0.5)
        togglePixel(i,j,ROW_PIXEL_NUM,COLUMN_PIXEL_NUM,1);
    else
        togglePixel(i,j,ROW_PIXEL_NUM,COLUMN_PIXEL_NUM,0);
}


function generateGrid(pixel_num_x,pixel_num_y)
{
    var table = document.createElement('table');
    for(var i = 0;i<pixel_num_y;i++){
    //table row
        var tr=document.createElement('tr');
        for(var j=0;j<pixel_num_x;j++){
            var td=document.createElement('td');
            td.appendChild(generatePixel(i,j,1.5,2));
            //table data
            tr.appendChild(td);
            }
    //insert table row
            table.appendChild(tr);
    }
    table.classList.add("grid");
    document.getElementById('canvas').appendChild(table)
}



function generatePixel(row_num,column_num,width,height)
{
    var temp = document.createElement("div");
    temp.classList.add(generatePixelClassName(row_num,column_num),"pixel");
    
    temp.style.width = width+'vw';
    temp.style.height = height+'vh';
    //temp.style.border = "1px solid #ddd";
    //blurry effects? 
    
    return temp;
}


function generatePixelClassName(row_num,column_num)
{
    return row_num+"_"+column_num;
}


function update_time()
{
        today=new Date()
        h=today.getHours()
        m=today.getMinutes()
        s=today.getSeconds()
        s0 = s%10;
        s1 = (s-s0)/10;
        h0 = h%10;
        h1 = (h-h0)/10;
        m0 = m%10;
        m1 = (m-m0)/10;
}

function sliderOnchange()
{
    clearInterval(timer);
    var elem = document.getElementById("frequency_slider");
    slider_value = elem.value;
    timer = setInterval(update,slider_value,display_test_allnumber_10);
}
