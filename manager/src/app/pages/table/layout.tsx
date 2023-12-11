import Loading from "@/component/Loading/loading"
import { Suspense } from "react"

export default function Layout({
    children, // will be a page or nested layout
}: {
    children: React.ReactNode
}) {
    return (
        <section>
            <Suspense fallback={<Loading />}>{children}</Suspense>
        </section>
    )
}