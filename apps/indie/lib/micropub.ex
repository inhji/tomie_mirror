defmodule Indie.Micropub do
	def get_post_type(properties) do
	  cond do
	    Map.has_key?(properties, "bookmark-of") ->
	      {:ok, :bookmark}

	    true ->
	      {:error, :unsupported_posttype}
	  end
	end

	def get_tags(%{"category" => [""]}), do: []
  def get_tags(%{"category" => tags}), do: tags
  def get_tags(_), do: []

  def get_title(%{"name" => [title]}), do: title
  def get_title(_), do: nil

  def get_content(%{"content" => [%{"html" => content_html}]}), do: content_html
  def get_content(%{"content" => [content]}), do: content
  def get_content(_), do: nil

  def get_bookmarked_url(%{"bookmark-of" => [url]}), do: url
  def get_bookmarked_url(_), do: nil

  def get_liked_url(%{"like-of" => [url]}), do: url
  def get_liked_url(_), do: nil

  def get_reply_to(%{"in-reply-to" => [reply_to]}), do: reply_to
  def get_reply_to(_), do: nil

  def is_published?(%{"post-status" => ["draft"]}), do: false
  def is_published?(_), do: true

  def get_photo(%{"photo" => [photo]}), do: photo
  def get_photo(_), do: nil

  def get_syndication_targets(%{"mp-syndicate-to" => targets}), do: targets
  def get_syndication_targets(_), do: []
end