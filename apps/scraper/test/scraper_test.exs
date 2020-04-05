defmodule ScraperTest do
  use ExUnit.Case
  doctest Scraper

  test "get_title/1 extracts the website title from the given html" do
    html = File.read!("./test/data/example.com.html")
    assert Scraper.get_title!(html) == "Example Domain"
  end

  test "parse/1 extracts the title and og properties when og properties are present" do
    html = File.read!("./test/data/github.com.html")
    {:ok, result} = Scraper.parse(html)
    assert result.title == "sheharyarn/que"
  end

  test "parse/1 extracts the title and og properties when og properties are not present" do
    html = File.read!("./test/data/example.com.html")
    {:ok, result} = Scraper.parse(html)
    assert result.title == "Example Domain"
  end
end
