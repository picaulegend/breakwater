import React, { useState } from "react";
import { Query, Mutation } from "react-apollo";
import gql from "graphql-tag";
import { css, jsx } from "@emotion/core";

const farm = gql`
  query Farm($id: ID!) {
    farm(id: $id) {
      id
      name
      stacks {
        id
        lighting
        slots {
          id
          name
          nutrition
          longevity
          health
          dayOfSeeding
          daysRequired
        }
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

const seedSlot = gql`
  mutation SeedSlot($slotId: ID!, $seedId: ID!) {
    seedSlot(slotId: $slotId, seedId: $seedId) {
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

export default function Farm({ availableSeeds, farmId }) {
  return (
    <Query query={farm} variables={{id: farmId}}>
      {({ data, loading, error }) => {
        console.log(data, error);
        return (
          <div>
            {loading ? (
              "loading..."
            ) : (
              <WithData data={data} availableSeeds={availableSeeds} />
            )}
          </div>
        );
      }}
    </Query>
  );
}

function WithData({ data, availableSeeds }) {
  const farm = data.farm;
  const stacks = farm.stacks;
  return (
    <div>
      <h2>Stacks</h2>
      <ul>
        {stacks.map((stack, index) => {
          return (
            <Stack
              key={stack.id}
              stackId={stack.id}
              index={index}
              slots={stack.slots}
              availableSeeds={availableSeeds}
            />
          );
        })}
      </ul>
      <Mutation mutation={addStack}>
        {(addStack, { loading: authenticating }) =>
          authenticating ? (
            "..."
          ) : (
            <button
              onClick={() =>
                addStack({
                  variables: { farmId: farm.id, lighting: "lots of light" }
                })
                  .then(res => {
                    console.log(res);
                  })
                  .catch(err => {
                    console.log(err);
                  })
              }
            >
              Add stack
            </button>
          )
        }
      </Mutation>
    </div>
  );
}

function Stack({ stackId, index, slots, availableSeeds }) {
  return (
    <li>
      <h3>Stack {index}</h3>
      <ul>
        {slots.map(slot => {
          return (
            <Slot
              key={slot.id}
              slotId={slot.id}
              availableSeeds={availableSeeds}
              name={slot.name}
              nutrition={slot.nutrition}
              longevity={slot.longevity}
              health={slot.health}
              dayOfSeeding={slot.dayOfSeeding}
              daysRequired={slot.daysRequired}
            />
          );
        })}
      </ul>
      <Mutation mutation={addSlot}>
        {(addSlot, { loading: authenticating }) =>
          authenticating ? (
            "..."
          ) : (
            <button
              onClick={() =>
                addSlot({
                  variables: { stackId }
                })
                  .then(res => {
                    console.log(res);
                  })
                  .catch(err => {
                    console.log(err);
                  })
              }
            >
              Add slot
            </button>
          )
        }
      </Mutation>
    </li>
  );
}

function Slot({
  slotId,
  name,
  nutrition,
  longevity,
  health,
  dayOfSeeding,
  daysRequired,
  availableSeeds = []
}) {
  const [seed, pickSeed] = useState("");
  return (
    <li>
      {name ? name : "empty slot"}
      <br />
      {name ? (
        <div>
          <ul>
            <li>nutrition: {nutrition}</li>
            <li>longevity: {longevity}</li>
            <li>health: {health}</li>
            <li>day of seeding: {dayOfSeeding}</li>
            <li>days required: {daysRequired}</li>
          </ul>
          <Mutation mutation={reapSlot}>
            {(reapSlot, { loading: authenticating }) =>
              authenticating ? (
                "..."
              ) : (
                <div>
                  <button
                    onClick={() =>
                      reapSlot({
                        variables: { slotId: slotId }
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
                </div>
              )
            }
          </Mutation>
        </div>
      ) : (
        <Mutation mutation={seedSlot}>
          {(seedSlot, { loading: authenticating }) =>
            authenticating ? (
              "..."
            ) : (
              <div>
                <h4>Available Seeds</h4>
                <ul>
                  {availableSeeds.map(availableSeed => {
                    return (
                      <li
                        key={availableSeed.id}
                        onClick={() => pickSeed(availableSeed)}
                      >
                        {availableSeed.name}
                      </li>
                    );
                  })}
                </ul>
                Seed picked: {seed ? seed.name : "none"}
                <button
                  onClick={() =>
                    seedSlot({
                      variables: { slotId: slotId, seedId: seed.id }
                    })
                      .then(res => {
                        console.log(res);
                      })
                      .catch(err => {
                        console.log(err);
                      })
                  }
                  disabled={!seed}
                >
                  Seed slot
                </button>
              </div>
            )
          }
        </Mutation>
      )}
    </li>
  );
}
