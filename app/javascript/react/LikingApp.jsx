import React from "react";
import axios from "axios";

export default function ({ createPath, likingUsersPath }) {
  const [users, setUsers] = React.useState([]);
  const [destroyPath, setDestroyPath] = React.useState(undefined);

  const alreadyLiked = destroyPath;
  const anyoneLiked = users.length > 0;

  React.useEffect(() => {
    (async () => {
      await fetchLikingUsers();
    })();
  }, []);

  const fetchLikingUsers = async () => {
    const json = await axios.get(likingUsersPath);
    setUsers(json.data.users);
    setDestroyPath(json.data.destroy_path);
  };

  const create = async () => {
    await axios.post(
      createPath,
      {},
      {
        headers: {
          "X-Requested-With": "XMLHttpRequest",
          "X-CSRF-Token": token(),
        },
      }
    );
    await fetchLikingUsers();
  };

  const destroy = async () => {
    await axios.delete(destroyPath, {
      headers: {
        "X-Requested-With": "XMLHttpRequest",
        "X-CSRF-Token": token(),
      },
    });
    await fetchLikingUsers();
  };

  const token = () => {
    const meta = document.querySelector('meta[name="csrf-token"]');
    return meta ? meta.getAttribute("content") : "";
  };

  return (
    <div>
      {alreadyLiked ? (
        <span>
          <button onClick={destroy} className="btn btn-link btn-like">
            <i className="bi bi-hand-thumbs-up-fill" />
          </button>
        </span>
      ) : (
        <span>
          <button onClick={create} className="btn btn-link btn-like">
            <i className="bi bi-hand-thumbs-up" />
          </button>
        </span>
      )}
      {anyoneLiked ? (
        <span className="liked-by">
          Liked by
          <ul>
            {users.map((user) => (
              <li key={user.id} className="cat-item">
                {user.nickname}
              </li>
            ))}
          </ul>
        </span>
      ) : (
        <span className="liked-by">Hit first like!</span>
      )}
    </div>
  );
}
