# child-spec-compat
[![Hex.pm Version](https://img.shields.io/hexpm/v/child_spec_compat.svg)](https://hex.pm/packages/child_spec_compat) [![Documentation](https://img.shields.io/badge/docs-latest-blue.svg)](https://hexdocs.pm/child_spec_compat/)

As of Elixir v1.5 there has been a [new pattern](https://elixir-lang.org/blog/2017/07/25/elixir-v1-5-0-released/) recommended for child specifications, rather than those which exist in `Supervisor.Spec` (which is now deprecated). This library provides a simple shim to compile the newer syntax on older Elixir versions with the same behaviour, to remove dependencies on the deprecated module. All of this happens at compile time to remove any overhead when you're on a supported version.

If you run your code purely on Elixir > v1.5, you should use `Supervisor.child_spec/2` directly; this module is aimed at library developers who provide support for older Elixir versions and cannot migrate exclusively to the new syntax.

### Installation

This library is available on [Hex](https://hex.pm/). You can install the package via:

  1. Add cachex to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:child_spec_compat, "~> 1.0"}]
end
```

### Usages

The intent of this module is to operate in the same way as `Supervisor.child_spec/2`, so please see the [official documentation](https://hexdocs.pm/elixir/1.5/Supervisor.html#child_spec/2). The only difference is that you need to call `ChildSpecCompat.child_spec/2` instead. As it's a macro, you need to either `require` or `import` the module in advance of using it. If examples are needed, please see the tests in this repo.
