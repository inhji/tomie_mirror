defmodule ScraperTest do
  use ExUnit.Case
  doctest Scraper

  describe "with fake html" do
    test "get_title/1 extracts the website title from the given html" do
      html = File.read!("./test/data/example.com.html")
      assert Scraper.get_title(html) == "Example Domain"
    end
  end

  describe "with real html" do
    test "get_title/1 extracts the website title from the given html" do
      {:ok, html} = Scraper.get_html("http://example.com")
      assert Scraper.get_title(html) == "Example Domain"
    end
  end
end
