Normally to serve up favicon in
    app/views/layouts/application.html.erb
we have
    <%= favicon_link_tag 'favicon.ico' %>
This translates to
    <link href="/assets/favicon-9f451f2aeb47dad190cf5e284cde33df.ico"
    rel="shortcut icon" type="image/vnd.microsoft.icon" />

rake assets:precompile generates
    -rw-rw-r-- 1 anthony developers 318 Mar  5 09:15 public/assets/favicon-9f451f2aeb47dad190cf5e284cde33df.ico
    -rw-rw-r-- 1 anthony developers 318 Apr  8 09:44 public/assets/favicon.ico
from
    ./app/assets/images/favicon.ico 
(i think)

But if we 404 (or whatever) the browser seems to request /favicon.ico
I, [2014-04-08T10:17:58.392857 #25620]  INFO -- : Started GET "/favicon.ico" for 143.239.9.1 at 2014-04-08 10:17:58 +0000
F, [2014-04-08T10:17:58.394790 #25620] FATAL -- : 
ActionController::RoutingError (No route matches [GET] "/favicon.ico"):

See here: http://stackoverflow.com/questions/15687506/actioncontrollerroutingerror-no-route-matches-get-favicon-ico-in-rails

"""
you're getting this error because you don't have a favicon.ico in your public/ directory of your application. Because the file doesn't exist there, Rails moves on, looking for a route to match against /favicon.ico in the config/routes.rb.

You can fix this in one of two ways

    Manually place the favicion.ico file in the public/ directory of your application.

    Put the favicon.ico in app/assets/images/ and then change your <link ... tag to use image_path

    <link href="<%= image_path("favicon.ico") %>" rel="shortcut icon" />

    This will place the favicon.ico in public/assets/favicon.ico, not in the document root.

I suggest sticking with #1 above.
"""

cp app/assets/images/favicon.ico public/
