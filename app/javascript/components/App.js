import React, { useState } from "react";
import { Mutation } from "react-apollo";
import gql from "graphql-tag";
import User from "./User";

const signin = gql`
  mutation SignMeIn($email: String!) {
    signIn(email: $email) {
      token
      user {
        id
      }
    }
  }
`;

export default () => {
  const [input, handleInput] = useState("");
  const token = localStorage.getItem("mlToken");
  return (
    <div>
      <div>
        <h1>BREAKRAILS</h1>
        {token ? (
          <div>
            <User />
            <button onClick={() => localStorage.removeItem("mlToken")}>
              Sign out
            </button>
          </div>
        ) : (
          <Mutation
            mutation={signin}
            // update={(cache, { data: { signIn } }) => {
            //   cache.writeQuery({
            //     query: user,
            //     data: { user: signIn.user }
            //   });
            // }}
          >
            {(signIn, { loading: authenticating }) =>
              authenticating ? (
                "..."
              ) : (
                <div>
                  <input
                    value={input}
                    onChange={e => handleInput(e.target.value)}
                  />
                  <button
                    onClick={() =>
                      signIn({
                        variables: { email: input }
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
                    Sign in please
                  </button>
                </div>
              )
            }
          </Mutation>
        )}
      </div>
    </div>
  );
};
