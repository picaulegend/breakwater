import React, { useState } from "react";
import { Query, Mutation } from "react-apollo";
import gql from "graphql-tag";
import { css, jsx } from "@emotion/core";

import Farm from "./Farm";
import Store from "./Store";

import "./user.css";

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

const forwardDay = gql`
  mutation ForwardDay {
    forwardDay {
      user {
        id
        money
        daysPlayed
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
  const [view, setView] = useState("farm");
  const user = data.user;
  if (!user) {
    localStorage.removeItem("mlToken");
    window.location.reload();
  }
  const { id, name, daysPlayed, money, seeds, products } = user;
  return (
    <div className="container">
      <div className="header">
        <div className="header-meta">
          <div className="header-left">
            {name} ({id})
          </div>{" "}
          <div className="header-right">
            Days played: {daysPlayed}, Money: {money}
          </div>
        </div>
        <nav className="header-navigation">
          <div className="header-left">
            <ul>
              {["Farm", "Inventory", "Store"].map((item, i) => {
                return (
                  <li key={i} onClick={() => setView(item.toLowerCase())}>
                    {item}
                  </li>
                );
              })}
            </ul>
          </div>
          <div className="header-right">
            <Mutation mutation={forwardDay}>
              {(forwardDay, { loading: authenticating }) =>
                authenticating ? (
                  "..."
                ) : (
                  <button
                    onClick={() =>
                      forwardDay()
                        .then(res => {
                          console.log(res);
                        })
                        .catch(err => {
                          console.log(err);
                        })
                    }
                  >
                    Next day
                  </button>
                )
              }
            </Mutation>
            <button onClick={() => localStorage.removeItem("mlToken")}>
              Sign out
            </button>
          </div>
        </nav>
      </div>

      {view === "farm" ? (
        <Farm
          availableSeeds={user.seeds}
          farmId={user.farm.id}
          daysPlayed={user.daysPlayed}
        />
      ) : view === "store" ? (
        <Store storeId={user.store.id} userId={id} />
      ) : view === "inventory" ? (
        <div>
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
        </div>
      ) : (
        ""
      )}
    </div>
  );
}
