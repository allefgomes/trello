defmodule FoodOrderWeb.LiveHelpers do
  import Phoenix.LiveView
  import Phoenix.LiveView.Helpers

  alias Phoenix.LiveView.JS

  def modal(assigns) do
    assigns = assign_new(assigns, :return_to, fn -> nil end)

    ~H"""
    <div id="modal" class="phx-modal fade-in rounded" data-role="modal" phx-remove={hide_modal()}>
      <div
              id="modal-content"
              class="phx-modal-content fade-in-scale shadow-md"
              phx-click-away={JS.dispatch("click", to: "#close")}
              phx-window-keydow={JS.dispatch("click", to: "#close")}
              phx-key="escape"
              >
        <%= if @return_to do %>
          <%= live_patch "x", to: @return_to, id: "close", class: "phx-modal-close", phx_click: hide_modal() %>
        <% else %>
        <a id="close" href="#" class="phx-modal-close" phx-click={hide_modal()}><small>x</small></a>
        <% end %>
        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end

  defp hide_modal(js \\ %JS{}) do
    js
    |> JS.hide(to: "#modal", transition: "fade-out")
    |> JS.hide(to: "#modal-content", transition: "fade-out-scale")
  end
end
