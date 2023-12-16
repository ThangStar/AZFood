'use client'
import styles from "../../../public/css/spiner.module.css";
import { Spinner } from 'reactstrap';
export default function Loading() {
    // You can add any UI inside Loading, including a Skeleton.
    return (
        <div className={styles.overlay}>
            <>
                <Spinner
                    color="primary"
                    type="grow"
                >
                </Spinner>
                <Spinner
                    color="secondary"
                    type="grow"
                >
                </Spinner>
                <Spinner
                    color="success"
                    type="grow"
                >
                </Spinner>
                <Spinner
                    color="danger"
                    type="grow"
                >
                </Spinner>
                <Spinner
                    color="warning"
                    type="grow"
                >
                </Spinner>
                <Spinner
                    color="info"
                    type="grow"
                >
                </Spinner>
                <Spinner
                    color="light"
                    type="grow"
                >
                    Loading...
                </Spinner>
                <Spinner
                    color="dark"
                    type="grow"
                >
                </Spinner>
            </>
        </div>
    )
}