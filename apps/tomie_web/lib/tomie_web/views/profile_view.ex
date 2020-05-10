defmodule TomieWeb.ProfileView do
  use TomieWeb, :view
  alias TomieWeb.ProfileLive

  def bookmarklet(current_user) do
    # url = Routes.live_url(TomieWeb.Endpoint, TomieWeb.BookmarkLive.New)
    # user = Pow.Plug.current_user(conn)
    url = "test"
    user = current_user

    """
    javascript:(function() {
      var t;
        try {
            t = ((window.getSelection && window.getSelection()) || (document.getSelection && document.getSelection()) || (document.selection && document.selection.createRange && document.selection.createRange().text));
        } catch (e) {
            t = \"\";
        };
        window.location = \"#{url}?url=\" + encodeURIComponent(window.location.href) + \"&content=\" + encodeURIComponent((t == '' ? '' : '> ' + t)) + \"&name=\" + encodeURIComponent(document.title) + \"&token=#{
      user.token
    }\";
    })();
    """
  end
end
