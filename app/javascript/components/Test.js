import React from "react";
import { Query, Mutation } from "react-apollo";
import gql from "graphql-tag";

const user = gql`
  query User {
    user {
      id
      products {
        id
        name
      }
      seeds {
        id
        produceType
      }
      farm {
        stacks {
          id
          slots {
            id
          }
        }
      }
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

const addStack = gql`
  mutation AddStack($farmId: ID!, $lighting: String!) {
    addStack(farmId: $farmId, lighting: $lighting) {
      stack {
        id
        lighting
      }
    }
  }
`;

const addSlot = gql`
  mutation AddSlot($stackId: ID!) {
    addSlot(stackId: $stackId) {
      slot {
        id
      }
    }
  }
`;

const reapSlot = gql`
  mutation ReapSlot($slotId: ID!) {
    reapSlot(slotId: $slotId) {
      product {
        id
      }
    }
  }
`;

export default () => (
  <Query query={user}>
    {({ data, loading, error }) => {
      console.log(error);
      return <div>{loading ? "loading..." : <WithData data={data} />}</div>;
    }}
  </Query>
);

function WithData({ data }) {
  console.log(data);
  if (data.user) {
    const user = data.user;
    const seeds = data.user.seeds;
    const farm = data.user.farm;
    const stacks = farm ? farm.stacks : [];
    const products = data.user.products;
    return (
      <div>
        HELLLO!!!!!!!!
        <User seeds={seeds} stacks={stacks} products={products} />
        <Mutation mutation={reapSlot}>
          {(reapSlot, { loading: authenticating }) =>
            authenticating ? (
              "..."
            ) : (
              <button
                onClick={() =>
                  reapSlot({
                    variables: { slotId: "1" }
                  })
                    .then(res => {
                      console.log(res);
                    })
                    .catch(err => {
                      console.log(err);
                    })
                }
              >
                Reap slot
              </button>
            )
          }
        </Mutation>
        <br />
        <br />{" "}
        <Mutation mutation={addStack}>
          {(addStack, { loading: authenticating }) =>
            authenticating ? (
              "..."
            ) : (
              <button
                onClick={() =>
                  addStack({
                    variables: { farmId: "1", lighting: "lots of light" }
                  })
                    .then(res => {
                      console.log(res);
                    })
                    .catch(err => {
                      console.log(err);
                    })
                }
              >
                Create stack
              </button>
            )
          }
        </Mutation>
        <Mutation mutation={addSlot}>
          {(addSlot, { loading: authenticating }) =>
            authenticating ? (
              "..."
            ) : (
              <button
                onClick={() =>
                  addSlot({
                    variables: { stackId: "1" }
                  })
                    .then(res => {
                      console.log(res);
                    })
                    .catch(err => {
                      console.log(err);
                    })
                }
              >
                Create slot
              </button>
            )
          }
        </Mutation>
      </div>
    );
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
                  variables: { email: "john.doe@example.com" }
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

function User({ seeds = [], stacks = [], products = [] }) {
  return (
    <div>
      <h2>Seeds</h2>
      <ul>
        {seeds.map(seed => {
          return <li key={seed.id}>{seed.name}</li>;
        })}
      </ul>
      <h2>Products</h2>
      <ul>
        {products.map(product => {
          return (
            <li key={product.id}>
              {product.name}, value: {product.value}
            </li>
          );
        })}
      </ul>
      <h2>Stacks</h2>
      {stacks.map(stack => {
        return (
          <li key={stack.id}>
            {stack.lighting}
            <ul>
              {stack.slots.map(slot => {
                return (
                  <li key={slot.id}>
                    {slot.seed ? slot.seed.name : "No seed"}
                  </li>
                );
              })}
            </ul>
          </li>
        );
      })}
    </div>
  );
}
