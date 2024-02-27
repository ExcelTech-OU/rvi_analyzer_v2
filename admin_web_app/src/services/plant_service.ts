import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'
import { List } from 'reselect/es/types'

export interface PlantListResponse {
    status: string
    statusDescription: string
    plants: List<Plant>
}

export interface Plant {
    name: string
    createdBy: string
    createdDateTime: string
    lastUpdatedDateTime: boolean
}

export interface PlantGetResponse {
    status: string,
    statusDescription: string,
    name: string
}

export const plantApi = createApi({
    reducerPath: 'plantApi',
    baseQuery: fetchBaseQuery({
        baseUrl: 'http://rvi.v2.exceltch.com/rvi-analyzer-api/',
        prepareHeaders: (headers) => {
            const token = localStorage.getItem("jwt") as string;
            if (!headers.has("Authorization") && token) {
                headers.set("Authorization", `Bearer ${token}`);
            }
            return headers;
        },
    }),
    tagTypes: ['plantList'],
    endpoints: (build) => ({
        getPlant: build.query<PlantListResponse, {}>({
            query: () => `rvi/analyzer/v1/plants`,
            providesTags: [{ type: 'plantList', id: "getPlants" }]

        }),
        addPlant: build.mutation<PlantGetResponse, {}>({
            query(body) {
                return {
                    url: `register/plant`,
                    method: 'POST',
                    body: body,
                }
            },
            invalidatesTags: [{ type: 'plantList', id: "getPlants" }]
        }),
    }),
})

export const {
    useGetPlantQuery,
    useAddPlantMutation,
} = plantApi