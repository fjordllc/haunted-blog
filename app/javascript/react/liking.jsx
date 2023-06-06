import React from "react";
import ReactDOM from "react-dom/client";
import LikingApp from "./LikingApp";

document.addEventListener("turbo:load", () => {
  const selector = "#liking-app";
  const app = document.querySelector(selector);
  if (app) {
    const createPath = app.getAttribute("data-create-path");
    const likingUsersPath = app.getAttribute("data-liking-users-path");
    const root = ReactDOM.createRoot(app);
    root.render(
      <LikingApp createPath={createPath} likingUsersPath={likingUsersPath} />
    );
  }
});
