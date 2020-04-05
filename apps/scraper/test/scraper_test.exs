defmodule ScraperTest do
  use ExUnit.Case
  doctest Scraper

  test "get_title/1 extracts the website title from the given html" do
    html = File.read!("./test/data/example.com.html")
    assert Scraper.get_title!(html) == "Example Domain"
  end

  test "parse/1 extracts the title and opengraph properties" do
    html = File.read!("./test/data/github.com.html")
    result = Scraper.parse(html)

    assert result.title == "sheharyarn/que"
  end
end
