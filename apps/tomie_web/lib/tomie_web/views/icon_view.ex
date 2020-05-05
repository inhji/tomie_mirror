defmodule TomieWeb.IconView do
  use TomieWeb, :view

  def icon(nil), do: ""
  def icon(name), do: svg_icon(name)

  defp svg_icon(:star) do
    ~E"""
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
      <path d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z"/>
    </svg>
    """
  end

  defp svg_icon(:link) do
    ~E"""
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
      <path d="M10 0l10 10-10 10L0 10 10 0zM6 10v3h2v-3h3v3l4-4-4-4v3H8a2 2 0 0 0-2 2z"/>
    </svg>
    """
  end

  defp svg_icon(:edit) do
    ~E"""
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
      <path d="M12.3 3.7l4 4L4 20H0v-4L12.3 3.7zm1.4-1.4L16 0l4 4-2.3 2.3-4-4z"/>
    </svg>
    """
  end

  defp svg_icon(:bookmark) do
    ~E"""
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
      <path d="M2 2c0-1.1.9-2 2-2h12a2 2 0 0 1 2 2v18l-8-4-8 4V2z"/>
    </svg>
    """
  end

  defp svg_icon(:time) do
    ~E"""
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
      <path d="M10 20a10 10 0 1 1 0-20 10 10 0 0 1 0 20zm0-2a8 8 0 1 0 0-16 8 8 0 0 0 0 16zm-1-7.59V4h2v5.59l3.95 3.95-1.41 1.41L9 10.41z"/>
    </svg>
    """
  end

  defp svg_icon(:arrow_outline_up) do
    ~E"""
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
      <path d="M10 0a10 10 0 1 1 0 20 10 10 0 0 1 0-20zm0 2a8 8 0 1 0 0 16 8 8 0 0 0 0-16zm2 8v5H8v-5H5l5-5 5 5h-3z"/>
    </svg>
    """
  end

  defp svg_icon(:inbox) do
    ~E"""
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
      <path d="M0 2C0 .9.9 0 2 0h16a2 2 0 0 1 2 2v16a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2zm14 12h4V2H2v12h4c0 1.1.9 2 2 2h4a2 2 0 0 0 2-2z"/>
    </svg>
    """
  end

  defp svg_icon(:heart) do
    ~E"""
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
      <path d="M10 3.22l-.61-.6a5.5 5.5 0 0 0-7.78 7.77L10 18.78l8.39-8.4a5.5 5.5 0 0 0-7.78-7.77l-.61.61z"/>
    </svg>
    """
  end

  defp svg_icon(:box) do
    ~E"""
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
      <path d="M0 2C0 .9.9 0 2 0h16a2 2 0 0 1 2 2v2H0V2zm1 3h18v13a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V5zm6 2v2h6V7H7z"/>
    </svg>
    """
  end

  defp svg_icon(:user) do
    ~E"""
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
      <path d="M5 5a5 5 0 0 1 10 0v2A5 5 0 0 1 5 7V5zM0 16.68A19.9 19.9 0 0 1 10 14c3.64 0 7.06.97 10 2.68V20H0v-3.32z"/>
    </svg>
    """
  end

  defp svg_icon(:light_bulb) do
    ~E"""
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
      <path d="M7 13.33a7 7 0 1 1 6 0V16H7v-2.67zM7 17h6v1.5c0 .83-.67 1.5-1.5 1.5h-3A1.5 1.5 0 0 1 7 18.5V17zm2-5.1V14h2v-2.1a5 5 0 1 0-2 0z"/>
    </svg>
    """
  end

  defp svg_icon(:home) do
    ~E"""
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
      <path d="M8 20H3V10H0L10 0l10 10h-3v10h-5v-6H8v6z"/>
    </svg>
    """
  end

  defp svg_icon(:checkmark) do
    ~E"""
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
      <path d="M0 11l2-2 5 5L18 3l2 2L7 18z"/>
    </svg>
    """
  end

  defp svg_icon(:refresh) do
    ~E"""
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
      <path d="M10 3v2a5 5 0 0 0-3.54 8.54l-1.41 1.41A7 7 0 0 1 10 3zm4.95 2.05A7 7 0 0 1 10 17v-2a5 5 0 0 0 3.54-8.54l1.41-1.41zM10 20l-4-4 4-4v8zm0-12V0l4 4-4 4z"/>
    </svg>
    """
  end

  defp svg_icon(:close_outline) do
    ~E"""
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
      <path d="M2.93 17.07A10 10 0 1 1 17.07 2.93 10 10 0 0 1 2.93 17.07zm1.41-1.41A8 8 0 1 0 15.66 4.34 8 8 0 0 0 4.34 15.66zm9.9-8.49L11.41 10l2.83 2.83-1.41 1.41L10 11.41l-2.83 2.83-1.41-1.41L8.59 10 5.76 7.17l1.41-1.41L10 8.59l2.83-2.83 1.41 1.41z"/>
    </svg>
    """
  end

  defp svg_icon(:add_outline) do
    ~E"""
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
      <path d="M11 9h4v2h-4v4H9v-4H5V9h4V5h2v4zm-1 11a10 10 0 1 1 0-20 10 10 0 0 1 0 20zm0-2a8 8 0 1 0 0-16 8 8 0 0 0 0 16z"/>
    </svg>
    """
  end

  defp svg_icon(:bookmark) do
    ~E"""
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
      <path d="M2 2c0-1.1.9-2 2-2h12a2 2 0 0 1 2 2v18l-8-4-8 4V2z"/>
    </svg>
    """
  end

  defp svg_icon(:music) do
    ~E"""
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
      <path d="M16 17a3 3 0 0 1-3 3h-2a3 3 0 0 1 0-6h2a3 3 0 0 1 1 .17V1l6-1v4l-4 .67V17zM0 3h12v2H0V3zm0 4h12v2H0V7zm0 4h12v2H0v-2zm0 4h6v2H0v-2z"/>
    </svg>
    """
  end

  defp svg_icon(:coffee) do
    ~E"""
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
      <path d="M4 11H2a2 2 0 0 1-2-2V5c0-1.1.9-2 2-2h2V1h14v10a4 4 0 0 1-4 4H8a4 4 0 0 1-4-4zm0-2V5H2v4h2zm-2 8v-1h18v1l-4 2H6l-4-2z"/>
    </svg>
    """
  end

  defp svg_icon(:cog) do
    ~E"""
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
      <path d="M3.94 6.5L2.22 3.64l1.42-1.42L6.5 3.94c.52-.3 1.1-.54 1.7-.7L9 0h2l.8 3.24c.6.16 1.18.4 1.7.7l2.86-1.72 1.42 1.42-1.72 2.86c.3.52.54 1.1.7 1.7L20 9v2l-3.24.8c-.16.6-.4 1.18-.7 1.7l1.72 2.86-1.42 1.42-2.86-1.72c-.52.3-1.1.54-1.7.7L11 20H9l-.8-3.24c-.6-.16-1.18-.4-1.7-.7l-2.86 1.72-1.42-1.42 1.72-2.86c-.3-.52-.54-1.1-.7-1.7L0 11V9l3.24-.8c.16-.6.4-1.18.7-1.7zM10 13a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
    </svg>
    """
  end

  defp svg_icon(:vinyl) do
    ~E"""
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
    <g>
    	<circle cx="256" cy="256" r="21.333"/>
    	<path d="M489.75,151.896c-2.063-4.583-6.917-7.115-11.979-6.094c-4.917,1.052-8.438,5.406-8.438,10.438v142.427
    		c0,2.802-1.146,5.552-3.125,7.542l-38.25,38.25c-4.167,4.167-4.167,10.917,0,15.083l6.25,6.25
    		c2.021,2.021,3.125,4.698,3.125,7.542s-1.104,5.521-3.125,7.542l-64,64c-4.042,4.021-11.042,4.021-15.083,0l-6.25-6.25
    		c-4.167-4.167-10.917-4.167-15.083,0l-6.25,6.25c-4.042,4.021-11.042,4.021-15.083,0c-2.021-2.021-3.125-4.698-3.125-7.542
    		s1.104-5.521,3.125-7.542l6.25-6.25c4.167-4.167,4.167-10.917,0-15.083l-6.25-6.25c-2.021-2.021-3.125-4.698-3.125-7.542
    		s1.104-5.521,3.125-7.542l64-64c4.042-4.021,11.042-4.021,15.083,0l6.25,6.25c4.167,4.167,10.917,4.167,15.083,0l32-32
    		c2-2,3.125-4.708,3.125-7.542V10.667C448,4.771,443.229,0,437.333,0c-5.896,0-10.667,4.771-10.667,10.667V65.62
    		C379.874,23.669,319.012,0,256,0C114.833,0,0,114.844,0,256s114.833,256,256,256s256-114.844,256-256
    		C512,220.031,504.521,185.01,489.75,151.896z M127.563,138.667c-2.729,0-5.438-1.042-7.521-3.115
    		c-4.188-4.156-4.188-10.906-0.042-15.083C156.292,84.052,204.583,64,256,64c5.896,0,10.667,4.771,10.667,10.667
    		c0,5.896-4.771,10.667-10.667,10.667c-45.688,0-88.625,17.823-120.875,50.198C133.042,137.625,130.292,138.667,127.563,138.667z
    		 M149.333,256c0-58.813,47.854-106.667,106.667-106.667S362.667,197.188,362.667,256S314.813,362.667,256,362.667
    		S149.333,314.813,149.333,256z"/>
    </g>
    </svg>
    """
  end

  defp svg_icon(:chart) do
    ~E"""
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
      <path d="M1 10h3v10H1V10zM6 0h3v20H6V0zm5 8h3v12h-3V8zm5-4h3v16h-3V4z"/>
    </svg>
    """
  end

  defp svg_icon(:tag) do
    ~E"""
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
      <path d="M0 10V2l2-2h8l10 10-10 10L0 10zm4.5-4a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3z"/>
    </svg>
    """
  end
end
