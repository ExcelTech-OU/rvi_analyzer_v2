import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'
import { List } from 'reselect/es/types'

export interface MaterialListResponse {
    status: string
    statusDescription: string
    materials: List<Material>
}

export interface Material {
    name: string
    plant: string
    customer: string
    style: string
    createdBy: string
    createdDateTime: string
}

export interface MaterialGetResponse {
    status: string,
    statusDescription: string,
    name: string
}

export const materialApi = createApi({
    reducerPath: 'materialApi',
    baseQuery: fetchBaseQuery({
        baseUrl: 'http://127.0.0.1:7550/',
        prepareHeaders: (headers) => {
            const token = localStorage.getItem("jwt") as string;
            if (!headers.has("Authorization") && token) {
                headers.set("Authorization", `Bearer ${token}`);
            }
            return headers;
        },
    }),
    tagTypes: ['materialList'],
    endpoints: (build) => ({
        getMaterial: build.query<MaterialListResponse, {}>({
            query: () => `rvi/analyzer/v1/materials`,
            providesTags: [{ type: 'materialList', id: "getMaterials" }]

        }),
        addMaterial: build.mutation<MaterialGetResponse, {}>({
            query(body) {
                return {
                    url: `register/material`,
                    method: 'POST',
                    body: body,
                }
            },
            invalidatesTags: [{ type: 'materialList', id: "getMaterials" }]
        }),
    }),
})

export const {
    useGetMaterialQuery,
    useAddMaterialMutation
} = materialApi