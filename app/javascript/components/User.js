import React from "react";
import { Query, Mutation } from "react-apollo";
import gql from "graphql-tag";
import { css, jsx } from "@emotion/core";

import Farm from "./Farm";
import Store from "./Store";

const user = gql`
  query User {
    user {
      id
      name
      daysPlayed
      money
      farm {
        id
      }
      store {
        id
      }
      seeds {
        id
        name
        produceType
      }
      products {
        id
        name
        value
      }
    }
  }
`;

const sellProduct = gql`
  mutation SellProduct($productId: ID!) {
    sellProduct(productId: $productId) {
      user {
        id
        money
      }
    }
  }
`;

export default function User() {
  return (
    <Query query={user}>
      {({ data, loading, error }) => {
        console.log({ error, data });
        return <div>{loading ? "loading..." : <WithData data={data} />}</div>;
      }}
    </Query>
  );
}

function WithData({ data }) {
  const user = data.user;
  if (!user) {
    localStorage.removeItem("mlToken");
    window.location.reload();
  }
  const { id, name, daysPlayed, money, seeds, products } = user;
  return (
    <div
      css={css`
        padding: 32px;
        background-color: hotpink;
        font-size: 24px;
        border-radius: 4px;
        color: orange;
      `}
    >
      User: {name}; {id}, Days played: {daysPlayed}, Money: {money}
      <br />
      <h2>Inventory:</h2>
      <h3>Seeds</h3>
      <ul>
        {seeds.map(seed => {
          return (
            <li key={seed.id}>
              {seed.name} - {seed.produceType}
            </li>
          );
        })}
      </ul>
      <h3>Products</h3>
      <Mutation mutation={sellProduct}>
        {(sellProduct, { loading: authenticating }) =>
          authenticating ? (
            "..."
          ) : (
            <ul>
              {products.map(product => {
                return (
                  <li key={product.id}>
                    {product.name}, value: {product.value}{" "}
                    <button
                      onClick={() =>
                        sellProduct({
                          variables: { productId: product.id }
                        })
                          .then(res => {
                            console.log(res);
                          })
                          .catch(err => {
                            console.log(err);
                          })
                      }
                    >
                      Sell
                    </button>
                  </li>
                );
              })}
            </ul>
          )
        }
      </Mutation>
      <br />
      <h2>Farm:</h2>
      <Farm availableSeeds={user.seeds} farmId={user.farm.id} />
      <Store storeId={user.store.id} userId={id} />
    </div>
  );
}
