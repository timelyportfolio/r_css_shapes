library(htmltools)
library(pipeR)


tagList(
  tags$style(
  '
    @import url(http://fonts.googleapis.com/css?family=Open+Sans:400italic,700italic,400);
      * {
        margin: 0; 
        padding: 0;
      }
      body {
        min-height: 1000px;
      }
      .demo {
        margin: 50px auto;
        font-family: "Open Sans";
        overflow: hidden;
        width: 700px;
      }
      
      .element {
        background-color: purple;
        width: 250px;
        height: 150px;
        float: left;
        border-radius: 50px;
        /* margin-bottom: 50px; */
          margin: 10px;
      }
      .element-2 {
        shape-outside: inset(0px round 50px) border-box;
        shape-margin: 10px;
      }
  '
  )
  , 
  '
<div class="demo">
  <div class="element">
  
  </div>
  <p>
    Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis dicta inventore nulla ullam est sed voluptates in iusto dolores neque vel dolore quibusdam consequatur delectus alias nobis magni hic sunt.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Hic similique minus facere laborum possimus natus voluptates aperiam cum voluptas deserunt est incidunt suscipit nulla autem laudantium dolor ratione eius tempora.</p>
  <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ab quasi saepe consectetur reprehenderit nostrum at enim provident quaerat harum error quod ea suscipit aspernatur ipsa nesciunt quidem voluptatum vitae fugit?</p>
</div>
<div class="demo">
  <div class="element element-2">
  </div>
  <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Repudiandae quidem ducimus natus ratione veritatis consequatur quasi perspiciatis dolorem aut iusto debitis eius odit illo animi inventore reprehenderit corrupti sed obcaecati.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Laboriosam laborum molestias tempore quod ex beatae inventore in magni dolores tempora maxime temporibus sequi ut commodi consectetur soluta vitae dolorum! Nemo.
  Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quas quos ut dicta neque eligendi consequatur dolores iure omnis repellat dolor beatae unde odio tempore iusto praesentium ab esse modi incidunt.</p>
</div>  
  ' %>>% HTML
) %>>% html_print()


library(base64)


pngfile <- tempfile()
png( pngfile, width = 600, height = 600 )
data.frame(
  y = sin(seq(0,pi,0.01))
  ,x = seq(0,pi,0.01)
) %>>% 
  (
    print( ggplot(data= .,aes(x=x,y=y)) + geom_area() + theme_bw() %>>%
    + theme(
        panel.background=element_blank()
        ,panel.border = element_blank()
        ,plot.background = element_blank()
        ,panel.grid.major = element_blank()
        ,panel.grid.minor = element_blank()
        ,panel.grid.major.y = element_blank()
        ,panel.grid.minor.y = element_blank()
      ) )
  )
dev.off()

#img(pngfile) %>>% HTML %>>% html_print

tagList(
  tags$style(
    sprintf("
      #container{
        background: url(%s)
        no-repeat
        left center;
        /*shape-outside: url(%s);
        shape-image-threshold: 0.5;/*
        float:left;
        width:600px;
        height:900px;
        overflow:hidden;
        margin:0 50px;
        color:white;
        font-size:13px;
        padding:10px;
        background-size:100%% 100%%;
        /*declare shape using the shape function circle()*/
        shape-outside: circle(160px at 400px 60px);
      }
      "  
      ,gsub(
        x=gsub(x=img(pngfile),pattern='(<img src=\")(.*)(\" alt.*)',replacement="\\2")
        ,pattern="\n"
        ,replacement=""
      )
      ,gsub(
        x=gsub(x=img(pngfile),pattern='(<img src=\")(.*)(\" alt.*)',replacement="\\2")
        ,pattern="\n"
        ,replacement=""
      )
    ) %>>% HTML %>>% noquote
  )
  ,tags$div(id="container")
  ,tags$p(
    noquote(paste0(rep(c(letters," "),100),collapse=""))
  )
) %>>% html_print()
