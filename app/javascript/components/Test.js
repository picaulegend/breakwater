import React from "react";
import { Query, Mutation } from "react-apollo";
import gql from "graphql-tag";

const user = gql`
  query User {
    user {
      id
      fullName
    }
  }
`;

const signin = gql`
  mutation SignMeIn($email: String!) {
    signIn(email: $email) {
      token
      user {
        id
        fullName
      }
    }
  }
`;

export default () => (
  <Query query={user}>
    {({ data, loading }) => (
      <div>{loading ? "loading..." : <WithData data={data} />}</div>
    )}
  </Query>
);

function WithData({ data }) {
  console.log(data);
  if (data) {
    return <div>BOING</div>;
  } else {
    return (
      <Mutation
        mutation={signin}
        update={(cache, { data: { signIn } }) => {
          cache.writeQuery({
            query: user,
            data: { user: signIn.user }
          });
        }}
      >
        {(signIn, { loading: authenticating }) =>
          authenticating ? (
            "..."
          ) : (
            <button
              onClick={() =>
                signIn({
                  variables: { email: "jane.doe@example.com" }
                })
                  .then(
                    ({
                      data: {
                        signIn: { token }
                      }
                    }) => {
                      if (token) {
                        localStorage.setItem("mlToken", token);
                      }
                    }
                  )
                  .catch(err => {
                    console.log(err);
                  })
              }
            >
              SIGN IN
            </button>
          )
        }
      </Mutation>
    );
  }
}
