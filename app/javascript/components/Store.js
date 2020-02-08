import React from "react";
import { Query, Mutation } from "react-apollo";
import gql from "graphql-tag";

const store = gql`
  query Store($id: ID!) {
    store(id: $id) {
      id
      name
      seeds {
        id
        name
        value
      }
    }
  }
`;

const buySeeds = gql`
  mutation BuySeeds($seedId: ID!) {
    buySeeds(seedId: $seedId) {
      seed {
        id
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
  const seeds = store ? store.seeds : [];
  return (
    <div>
      <ul>
        {seeds.map(seed => {
          return (
            <li key={seed.id}>
              {seed.name} ({seed.value}){" "}
              <Mutation mutation={buySeeds}>
                {(buySeeds, { loading: authenticating }) =>
                  authenticating ? (
                    "..."
                  ) : (
                    <button
                      onClick={() =>
                        buySeeds({
                          variables: {
                            seedId: seed.id
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
