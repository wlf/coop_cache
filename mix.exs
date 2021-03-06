defmodule CoopCache.Mixfile do
  use Mix.Project

  def project do
    [app: :coop_cache,
     version: "2.0.0",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [
        mod: {CoopCache, []}
    ]
  end


  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps() do
    [
      {:flock, [git: "git@github.com:wooga/flock.git", tag: "0.4.1"]},
      {:wormhole, [git: "https://github.com/renderedtext/wormhole.git", branch: "master"]}
    ]
  end
end
