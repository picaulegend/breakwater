import React from "react";
import { Query, Mutation } from "react-apollo";
import gql from "graphql-tag";

const store = gql`
  query Store($id: ID!) {
    store(id: $id) {
      id
      name
      items {
        id
        seed {
          id
          name
          value
        }
        amountInStock
      }
    }
  }
`;

const buySeeds = gql`
  mutation BuySeeds($itemId: ID!) {
    buySeeds(itemId: $itemId) {
      errors {
        details
        fullMessages
      }
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
  }
`;

export default function Store({ storeId }) {
  return (
    <div>
      <h1>Breakwater Store</h1>
      <Query query={store} variables={{ id: storeId }}>
        {({ data, loading, error }) => {
          console.log(data, error);
          return <div>{loading ? "loading..." : <WithData data={data} />}</div>;
        }}
      </Query>
    </div>
  );
}

function WithData({ data }) {
  const store = data.store;
  const items = store ? store.items : [];
  return (
    <div>
      <ul>
        {items.map(item => {
          const seed = item.seed;
          return (
            <li key={item.id}>
              {seed && (
                <span>
                  {seed.name} ({seed.value})
                </span>
              )}
              <br />
              Amount in stock: {item.amountInStock}{" "}
              <Mutation mutation={buySeeds}>
                {(buySeeds, { loading: authenticating }) =>
                  authenticating ? (
                    "..."
                  ) : (
                    <button
                      onClick={() =>
                        buySeeds({
                          variables: {
                            itemId: item.id
                          }
                        })
                          .then(res => {
                            console.log(res);
                          })
                          .catch(err => {
                            console.log(err);
                          })
                      }
                    >
                      Buy seed
                    </button>
                  )
                }
              </Mutation>
            </li>
          );
        })}
      </ul>
    </div>
  );
}
