defmodule Indie.Token do
  require Logger

  alias HTTPoison.Response

  @supported_scopes Application.compile_env!(:indie, :supported_scopes)
  @token_endpoint Application.compile_env!(:indie, :token_endpoint)

  @hostname Application.get_env(:tomie, [TomieWeb.Endpoint, :url, :host])

  def verify(access_token, required_scope) do
    headers = [authorization: "Bearer #{access_token}", accept: "application/json"]

    with {:ok, %Response{status_code: 200, body: body}} <-
           Http.get(@token_endpoint, headers),
         {:ok, body_map} <- Jason.decode(body),
         :ok <- verify_token_response(body_map, required_scope) do
      :ok
    else
      {:error, %HTTPoison.Response{status_code: code}} ->
        Logger.error("Token endpoint responded with unexpected code: #{inspect(code)}")
        {:error, :insufficient_scope, code}

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("Could not reach token endpoint: #{inspect(reason)}")
        {:error, :insufficient_scope, reason}

      {:error, name, reason} ->
        Logger.error("Error #{reason} in #{name}")
        {:error, :insufficient_scope, reason}

      error ->
        Logger.error("Unexpected error: #{inspect(error)}")
        {:error, :insufficient_scope, "Internal Server Error"}
    end
  end

  defp verify_token_response(
         %{
           "me" => hostname,
           "scope" => scope,
           "client_id" => client_id,
           "issued_at" => _issued_at,
           "issued_by" => _issued_by,
           "nonce" => _nonce
         },
         required_scope
       ) do
    Logger.info("Hostname: '#{hostname}'")
    Logger.info("ClientId: #{client_id}")
    Logger.info("Scopes: '#{scope}'")

    with :ok <- verify_hostname_match(hostname),
         :ok <- verify_scope_support(scope, required_scope, @supported_scopes) do
      :ok
    else
      {:error, name, reason} ->
        Logger.error("Could not verify token response: #{reason}")
        {:error, name, reason}
    end
  end

  defp verify_hostname_match(hostname) do
    hostnames_match? = sanitize_hostname(hostname) == @hostname

    case hostnames_match? do
      true ->
        :ok

      _ ->
        Logger.warn("Hostnames do not match: Given #{hostname}, Actual: #{@hostname}")
        {:error, "verify_hostname_match", "hostname does not match"}
    end
  end

  defp sanitize_hostname(hostname) do
    String.trim_trailing(hostname, "/")
  end

  defp verify_scope_support(scopes, nil, _supported_scopes), do: {:ok, scopes}

  defp verify_scope_support(scopes, required_scope, supported_scopes) do
    required = Enum.member?(supported_scopes, required_scope)
    requested = Enum.member?(String.split(scopes), required_scope)

    cond do
      required && requested ->
        :ok

      !required ->
        {:error, "verify_scope_support", "scope '#{required_scope}' is not supported"}

      !requested ->
        {:error, "verify_scope_support", "scope '#{required_scope}' was not requested"}
    end
  end
end
