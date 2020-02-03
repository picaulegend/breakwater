import React from "react";
import { Query } from "react-apollo";
import gql from "graphql-tag";

import Test from "./Test";

const LibraryQuery = gql`
  {
    items {
      id
      title
      user {
        email
      }
    }
  }
`;

export default () => (
  <Query query={LibraryQuery}>
    {({ data, loading }) => (
      <div>
        {loading ? (
          "loading..."
        ) : (
          <div>
            {data.items.map(({ title, id, user }) => (
              <div key={id}>
                <b>{title}</b> {user ? `added by ${user.email}` : null}
              </div>
            ))}
            <Test />
          </div>
        )}
      </div>
    )}
  </Query>
);
