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
            <h1>BREAKRAILS</h1>
            <Test />
          </div>
        )}
      </div>
    )}
  </Query>
);
