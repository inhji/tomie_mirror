defmodule Notes.Tree do
  use CTE,
    otp_app: :notes,
    adapter: CTE.Adapter.Ecto,
    repo: Db.Repo,
    nodes: Notes.Note,
    paths: Notes.NotePath
end
